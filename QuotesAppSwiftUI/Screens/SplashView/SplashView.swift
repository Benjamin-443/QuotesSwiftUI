//
//  SplashView.swift
//  Quotes
//
//  Created by Zan on 07/04/2025.
//

import SwiftUI

struct SplashView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Text("Quotes.")
                .font(.custom("AvenirNext-Bold", size: 34))
                .fontWeight(.bold)
            Text("Motivate Yourself With US!")
                .font(.custom("AvenirNext-Medium", size: 20))
                .fontWeight(.semibold)
            
            Spacer()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
