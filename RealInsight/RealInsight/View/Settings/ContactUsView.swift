//
//  ContactUsView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 13/2/24.
//

import SwiftUI

struct ContactUsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                TopBarView(backButtonAction: {
                    dismiss()
                }, title: "How can we help you?")
                MainMenuOptions()
            }
        }
    }
}

private struct MainMenuOptions: View {
    var body: some View {
        VStack {
            VStack(spacing: 28) {
                CustomContactButton(
                    icon: "questionmark.circle",
                    text: "Ask a Question"
                ) {}
                CustomContactButton(
                    icon: "ladybug",
                    text: "Report a Problem"
                ) {}
                CustomContactButton(
                    icon: "atom",
                    text: "Become Beta Tester"
                ) {}
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 80)
    }
}

private struct CustomContactButton: View {
    var icon: String
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 45)
                    .foregroundColor(Color(red: 28/255, green: 28/255, blue: 30/255))
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(.white)
                    Text(text)
                }
                .foregroundColor(.white)
            }
        }
    }
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}
