//
//  EnterCodeView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 26/2/24.
//

import SwiftUI
import Combine

struct EnterCodeView: View {
    
    @State var otpCode: String = ""
    @State var buttonActive: Bool = false
    @State var timeReamining = 60
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    HStack {
                        Spacer()
                        Text("RealInsights.")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 22))
                        Spacer()
                    }
                    Spacer()
                }
                
                VStack {
                    VStack {
                        VStack(alignment: .center, spacing: 8) {
                            Text("Enter the code we sent to +39 389 939 02 12")
                                .foregroundColor(.white)
                                .fontWeight(.medium)
                                .font(.system(size: 16))
                            
                            Text(".......")
                                .foregroundColor(otpCode.isEmpty ? .gray: .white)
                                .opacity(0.8)
                                .font(.system(size: 70))
                                .padding(.top, -40)
                                .overlay(
                                    TextField("", text: $otpCode)
                                        .foregroundColor(otpCode.isEmpty ? .gray: .white)
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 24, weight: .heavy))
                                        .keyboardType(.numberPad)
                                        .onReceive(Just(otpCode), perform: { _ in
                                            limitText(6)
                                        })
                                        .onReceive(Just(otpCode), perform: { newValue in
                                            let filtered = newValue.filter({
                                                Set("0123456789").contains($0)
                                            })
                                            if filtered != newValue {
                                                otpCode = filtered
                                            }
                                        })
                                )
                        }
                        .padding(.top, 50)
                        Spacer()
                    }
                    
                    VStack {
                        Text("Change the phone number")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                        
                        Button {
                            
                        } label: {
                            WhiteButtonView(buttonActive: $buttonActive, text: otpCode.count == 6 ? "Continue": "Resend in \(timeReamining) ")
                        }
                        .disabled(!buttonActive)
                        .onChange(of: otpCode) { newValue in
                            buttonActive = !newValue.isEmpty
                        }
                    }
                    
                }
                .padding(.bottom, 20)
            }.onReceive(timer) { _ in
                if timeReamining > 0 {
                    timeReamining -= 1
                } else {
                   buttonActive = true
                }
            }
        }
    }
    
    func limitText(_ upper: Int) {
        if otpCode.count > upper {
            otpCode = String(otpCode.prefix(upper))
        }
    }
    
    
}

struct EnterCodeView_Previews: PreviewProvider {
    static var previews: some View {
        EnterCodeView()
    }
}
