//
//  EnterNameView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 26/2/24.
//

import SwiftUI

struct EnterNameView: View {
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                TopBar()
                NameInputView()
                ContinueButton()
            }
        }
    }
}

private struct TopBar: View {
    var body: some View {
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
    }
}

private struct NameInputView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            VStack {
                Text("Let's get started, what's your name?")
                    .fontWeight(.heavy)
                    .font(.system(size: 16))
                
                Text(viewModel.name.isEmpty ? "Your name": "")
                    .foregroundColor(viewModel.name.isEmpty ? Color(red: 70/255, green: 70/255, blue: 73/255): Color.black)
                    .fontWeight(.heavy)
                    .font(.system(size: 40))
                    .frame(width: 210)
                    .overlay(
                        TextField("", text: $viewModel.name)
                            .font(.system(size: 40, weight: .heavy))
                            .multilineTextAlignment(.center)
                    )
                    .padding(.top, 5)
            }
            .foregroundColor(.white)
            Spacer()
        }
        .padding(.top, 50)
    }
}

private struct ContinueButton: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    @State var buttonActive: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            Button {
                viewModel.nextAuthFlowStep()
            } label: {
                WhiteButtonView(buttonActive: $buttonActive, text: "Continue")
                    .onChange(of: viewModel.name) { newValue in
                        buttonActive = !newValue.isEmpty
                    }
            }
        }.padding(.bottom, 40)
    }
}

struct EnterNameView_Previews: PreviewProvider {
    static var previews: some View {
        EnterNameView()
    }
}
