//
//  NetworkManager.swift
//  NetworkLayer
//
//  Created by Zan on 07/04/2025.
//

import Combine
import Foundation
import UIKit

public protocol NetworkManagerProtocol: Any {
    var session: URLSession { get }
    func request<Route: Router>(_ route: Route) -> Future<Route.Response, Error>
}

public final class NetworkManager: NetworkManagerProtocol {
    public var session: URLSession
    private var cancellables = Set<AnyCancellable>()
    private let sessionDelegate = SSLSessionDelegate()

    init(_ session: URLSession = .shared) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = kTimeoutInterval
        configuration.requestCachePolicy = kRequestCachePolicy
        
        self.session = URLSession(configuration: configuration,
                                 delegate: sessionDelegate,
                                 delegateQueue: nil)
    }

    public convenience init(configuration: URLSessionConfiguration) {
        self.init()
        self.session = URLSession(configuration: configuration,
                                 delegate: sessionDelegate,
                                 delegateQueue: nil)
    }

    public func request<Route: Router>(_ route: Route) -> Future<Route.Response, Error> {
        return Future<Route.Response, Error> {[weak self] promise in

            guard let self = self else {
                return promise(.failure(RequestError.unknown()))
            }

            guard NetworkMonitor.shared.isConnectd else {
                return promise(.failure(NetworkError.unreachable()))
            }

            guard let request = route.request() else {
                return promise(.failure(RequestError.invalidURL()))
            }

            NetworkLogger.log(request: request)
            return self.session.dataTaskPublisher(for: request)
                .tryMap { (data, response) -> Data in
                    NetworkLogger.log(response: response)
                    if let response = response as? HTTPURLResponse, !response.statusCode.isSuccess {
                        throw route.errorParser.parse(.mapRequestError(response.statusCode))
                    }
                    return data
                }
                .decode(type: Route.Response.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        NetworkLogger.log(error: error)
                        promise(.failure(route.errorParser.parse(.handleRequestError(error))))
                    }
                }, receiveValue: { promise(.success($0)) })
                .store(in: &self.cancellables)
        }
    }
}

class SSLSessionDelegate: NSObject, URLSessionDelegate {
    func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    ) {
        
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            if let serverTrust = challenge.protectionSpace.serverTrust {
                if kNetworkEnvironment == .production {
                    let isServerTrusted = evaluateServerTrust(serverTrust, for: challenge.protectionSpace.host)
                    
                    if isServerTrusted {
                        let credential = URLCredential(trust: serverTrust)
                        completionHandler(.useCredential, credential)
                        return
                    }
                } else {
                    let credential = URLCredential(trust: serverTrust)
                    completionHandler(.useCredential, credential)
                    return
                }
            }
        }
        
        completionHandler(.performDefaultHandling, nil)
    }
    
    private func evaluateServerTrust(
        _ serverTrust: SecTrust,
        for host: String
    ) -> Bool {
        let policy = SecPolicyCreateSSL(true, host as CFString)
        
        SecTrustSetPolicies(serverTrust, [policy] as CFTypeRef)
        
        let result: SecTrustResultType = .invalid
//        SecTrustEvaluate(serverTrust, &result)
        return result == .proceed || result == .unspecified
    }
}
