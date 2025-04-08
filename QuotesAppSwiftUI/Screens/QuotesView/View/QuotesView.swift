//
//  QuotesView.swift
//  QuotesAppSwiftUI
//
//  Created by Zan on 07/04/2025.
//

import SwiftUI
import Combine

struct QuotesView: View {
    
    @StateObject private var viewModel = QuotesViewModel()
    @State private var selectedQuote: Quote?
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Quotes")
                .navigationDestination(item: $selectedQuote){ quote in
                    QuoteView(viewModel: QuoteViewModel(quote: quote))
                }
                .task {
                    viewModel.transform(input: .load)
                }
                .refreshable {
                    viewModel.transform(input: .refresh)
                }
        }
    }
}

private extension QuotesView {
    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .notLoaded:
            ProgressView()
        case .loaded(let quotes):
            ListView(quotes: quotes, selectedQuote: $selectedQuote)
                .listRowSpacing(16.0)
                .scrollIndicators(.hidden)
                .listStyle(PlainListStyle())
        case .noData:
            ContentUnavailableView(
                "No Data Available",
                systemImage: "quote.bubble",
                description: Text("Please try it later")
            )
        case .error(let error):
            ContentUnavailableView(
                "An Error Occured",
                systemImage: "exclamationmark.triangle",
                description: Text("Error: \(error.localizedDescription)")
            )
        }
    }
}

private extension QuotesView {
    struct ListView: View {
        var quotes: [Quote]
        @Binding var selectedQuote: Quote?
        
        var body: some View {
            List(quotes) { quote in
                QuoteCellView(quote: quote)
                    .padding(.horizontal, 16.0)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .onTapGesture {
                        selectedQuote = quote
                        print("Quote: ", quote);
                    }
            }
        }
    }
}

private extension QuotesView {
    struct QuoteCellView: View {
        var quote: Quote
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text("\"\(quote.content)\"")
                    .font(.custom("AvenirNext-Medium", size: 16))
                    .foregroundColor(Color(hex: "0B192C"))
                Text("- \(quote.author)")
                    .font(.custom("AvenirNext-Regular", size: 10))
                    .foregroundColor(Color(hex: "0B192C"))
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
            }
            .padding()
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .background((Color(hex: "FFA725").opacity(0.2)))
            .clipShape(RoundedRectangle(cornerRadius: 16.0))
        }
    }
}

#Preview {
    QuotesView()
}

