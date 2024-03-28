//
//  TabBarMenuView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 5/3/24.
//

import SwiftUI

struct TabBarMenuView<Tab: Hashable>: View {
    var tabs: [Tab]
    @Binding var selectedTab: Tab
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 22)
                        .frame(width: UIScreen.main.bounds.width * 0.82, height: 40)
                        .foregroundColor(Color(red: 20/255, green: 20/255, blue: 20/255))
                    HStack(spacing: 4) {
                        ForEach(tabs, id: \.self) { tab in
                            Capsule()
                                .frame(width: 100, height: 28)
                                .foregroundColor(Color(red: 46/255, green: 46/255, blue: 48/255))
                                .opacity(selectedTab == tab ? 1 : 0)
                                .overlay(
                                    Text(String(describing: tab))
                                        .foregroundColor(.white)
                                        .font(.system(size: 14))
                                ).onTapGesture {
                                    withAnimation {
                                        self.selectedTab = tab
                                    }
                                }
                        }
                        
                    }
                    .zIndex(1)
                    LinearGradient(colors: [.black, .white.opacity(0)], startPoint: .bottom, endPoint: .top)
                        .ignoresSafeArea()
                        .frame(height: 60)
                        .opacity(0.9)
                }
            }
        }
    }
}

struct TabBarMenuView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarMenuView(tabs: ["Suggestions", "Friends", "Requests"], selectedTab: .constant("Suggestions"))
    }
}
