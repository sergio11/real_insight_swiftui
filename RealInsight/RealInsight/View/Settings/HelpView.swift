//
//  HelpView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 13/2/24.
//

import SwiftUI

struct HelpView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                TopBarView(backButtonAction: {
                    dismiss()
                }, title: "Help")
                VStack {
                    MainMenuOptions()
                }
            }
        }
    }
}

private struct MainMenuOptions: View {
    var body: some View {
        VStack(spacing: 16) {
            ContactUsButton()
            HelpButton()
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 50)
    }
}

private struct ContactUsButton: View {
    var body: some View {
        NavigationLink {
            ContactUsView().navigationBarBackButtonHidden()
        } label: {
            ChevronButtonView(icon: "envelope", text: "Contact us")
        }
    }
}

private struct HelpButton: View {
    var body: some View {
        NavigationLink {
            
        } label: {
            ChevronButtonView(icon: "questionmark.circle", text: "Help Center")
        }
    }
}


struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
