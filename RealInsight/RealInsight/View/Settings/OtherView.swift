//
//  OtherView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 13/2/24.
//

import SwiftUI

struct OtherView: View {
    
    @State var fastCamera = false
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                TopBarView()
                VStack {
                    MainMenuOptions()
                    Spacer()
                }
            }
        }
    }
}


private struct TopBarView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ZStack {
                Text("Other")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                    }
                    Spacer()
                }.padding(.horizontal)
            }
            Spacer()
        }
    }
}


private struct MainMenuOptions: View {
    var body: some View {
        VStack(spacing: 14) {
            ListItemView(
                iconName: "camera.viewfinder",
                title: "Fast camera (reduces quality)",
                foregroundColor: .white
            )
            ListItemView(
                iconName: "xmark.app",
                title: "Clear cache",
                foregroundColor: .white,
                trailingIcon: "chevron.right"
            )
            ListItemView(
                title: "Delete account",
                foregroundColor: .red,
                centerText: true
            )
        }
        .padding(.horizontal)
        .padding(.top, 50)
    }
}


private struct ListItemView: View {
    var iconName: String? = nil
    var title: String
    var foregroundColor: Color
    var trailingIcon: String? = nil
    var centerText: Bool = false
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 45)
                    .foregroundColor(Color(red: 28/255, green: 28/255, blue: 30/255))
                
                HStack {
                    if let iconName = iconName {
                        Image(systemName: iconName)
                            .foregroundColor(foregroundColor)
                            .font(.system(size: 18))
                    }
                    
                    if centerText {
                        Spacer()
                    }
                    
                    Text(title)
                        .foregroundColor(foregroundColor)
                        .fontWeight(.medium)
                        .font(.system(size: 14))
                    
                    Spacer()
                    
                    if let iconName = trailingIcon {
                        Image(systemName: iconName)
                            .foregroundColor(foregroundColor)
                            .font(.system(size: 14))
                    }
                }
                .padding(.horizontal, UIScreen.main.bounds.width * 0.04)
                .frame(height: 30)
            }
        }
    }
}


struct OtherView_Previews: PreviewProvider {
    static var previews: some View {
        OtherView()
    }
}
