//
//  TabView.swift
//  QuotesAppSwiftUI
//
//  Created by Zan on 07/04/2025.
//

import SwiftUI

//struct MainTabView: View {
//    var body: some View {
//        TabView {
//            QuoteView(viewModel: QuoteViewModel())
//                .tabItem {
//                    Label("Home", systemImage: "house.fill")
//                        .font(.custom("AvenirNext-Bold", size: 14))
//                }
//            
//            QuotesView()
//                .tabItem {
//                    Label("Quotes", systemImage: "quote.bubble")
//                        .font(.custom("AvenirNext-Bold", size: 14))
//                }
//            
//            AuthorsView()
//                .tabItem {
//                    Label("Authors", systemImage: "person.crop.circle")
//                        .font(.custom("AvenirNext-Bold", size: 14))
//                }
//        }
//        .accentColor(Color(hex: "213555"))
//    }
//}

//#Preview {
//    MainTabView()
//}

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            // This displays the selected content
            TabContent(selectedTab: selectedTab)
                .frame(maxHeight: .infinity)
            
            // Custom Tab Bar at the bottom
            CustomTabBar(selectedTab: $selectedTab)
                .background(Color.white) // Ensures tab bar has solid background
        }
        .edgesIgnoringSafeArea(.bottom) // Only ignore bottom safe area for the tab bar
    }
}

struct TabContent: View {
    let selectedTab: Int
    
    var body: some View {
        switch selectedTab {
        case 0:
            QuoteView(viewModel: QuoteViewModel())
        case 1:
            QuotesView()
        case 2:
            AuthorsView()
        default:
            QuoteView(viewModel: QuoteViewModel())
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    // Tab items data
    let tabs = [
        (title: "Home", icon: "house.fill"),
        (title: "Quotes", icon: "text.bubble"),
        (title: "Authors", icon: "person.crop.circle")
    ]
    
    var body: some View {
        HStack {
            Spacer()
            
            // Custom tab bar container
            ZStack {
                // Background capsule
                Capsule()
                    .fill(Color(UIColor.systemBlue).opacity(0.2))
                    .frame(height: 60)
                    .padding(.horizontal, 18)
                
                // Tab items
                HStack {
                    ForEach(0..<tabs.count, id: \.self) { index in
                        Button(action: {
                            selectedTab = index
                        }) {
                            if selectedTab == index {
                                // Active tab with background
                                HStack(spacing: 0) {
                                    if !tabs[index].title.isEmpty {
                                        Text(tabs[index].title)
                                            .font(.system(size: 14, weight: .medium))
                                    }
                                }
                                .foregroundColor(.black)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 15)
                                .background(Capsule().fill(Color(UIColor.systemBlue).opacity(0.3)))
                            } else {
                                // Inactive tab without background
                                Image(systemName: tabs[index].icon)
                                    .font(.system(size: 16))
                                    .foregroundColor(Color.black.opacity(0.6))
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal, 12)
            }
            
            Spacer()
        }
        .padding(.bottom, 8)
        .padding(.bottom, 20)
    }
}


