//
//  EnterNameView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 26/2/24.
//

import SwiftUI

struct EnterNameView: View {
    
    @State var name: String = ""
    @State var buttonActive: Bool = false
    @Binding var buttonClicked: Bool
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    HStack {
                        Spacer()
                        Text("RealInsight.")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 22))
                        Spacer()
                    }
                    Spacer()
                }
                VStack {
                    VStack {
                        Text("Let's get started, what's your name?")
                            .fontWeight(.heavy)
                            .font(.system(size: 16))
                        
                        Text(name.isEmpty ? "Your name": "")
                            .foregroundColor(name.isEmpty ? Color(red: 70/255, green: 70/255, blue: 73/255): Color.black)
                            .fontWeight(.heavy)
                            .font(.system(size: 40))
                            .frame(width: 210)
                            .overlay(
                                TextField("", text: $name)
                                    .font(.system(size: 40, weight: .heavy))
                            )
                            .padding(.top, 5)
                    }
                    .foregroundColor(.white)
                    Spacer()
                }
                .padding(.top, 50)
                
                VStack {
                    Spacer()
                    Button {
                        buttonClicked = true
                    } label: {
                        WhiteButtonView(buttonActive: $buttonActive, text: "Continue")
                            .onChange(of: name) { newValue in
                                buttonActive = !newValue.isEmpty
                            }
                    }
                }
            }
        }
    }
}

struct EnterNameView_Previews: PreviewProvider {
    static var previews: some View {
        EnterNameView(buttonClicked: .constant(true))
    }
}
