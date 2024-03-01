//
//  EnterAgeView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 26/2/24.
//

import SwiftUI
import Combine

struct EnterAgeView: View {
    
    @Binding var birthdate: Birthdate
    @Binding var name: String
    @Binding var buttonClicked: Bool
    
    @State var buttonActive = false
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
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
                
                VStack(alignment: .center, spacing: 8) {
                    Text("Hi \(name), when's your birthday?")
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .font(.system(size: 16))
                    
                    HStack(spacing: 4) {
                        Text("MM")
                            .foregroundColor(birthdate.month.isEmpty ? Color(red: 70/255, green: 70/255, blue: 73/255) : Color.black)
                            .fontWeight(.heavy)
                            .font(.system(size: 40))
                            .frame(width: 72)
                            .overlay(
                                TextField("", text: $birthdate.month)
                                    .foregroundColor(.white)
                                    .font(.system(size: 45, weight: .heavy))
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.numberPad)
                                    .onReceive(Just(birthdate.month), perform: { newValue in
                                        let filtered = newValue.filter {
                                            Set("0123456789").contains($0)}
                                            if filtered != newValue {
                                                self.birthdate.month = filtered
                                            }
                                        }
                                              ).onReceive(Just(birthdate.month), perform: { _ in
                                                  if birthdate.month.count > 2 {
                                                      birthdate.month = String(birthdate.month.prefix(2))
                                        }
                                    })
                            )
                        
                        Text("DD")
                            .foregroundColor(birthdate.day.isEmpty ? Color(red: 70/255, green: 70/255, blue: 73/255): Color.black)
                            .fontWeight(.heavy)
                            .font(.system(size: 40))
                            .frame(width: 58)
                            .overlay(
                                TextField("", text: $birthdate.day)
                                    .foregroundColor(.white)
                                    .font(.system(size: 45, weight: .heavy))
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.numberPad)
                                    .onReceive(Just(birthdate.day), perform: { newValue in
                                        let filtered = newValue.filter {
                                            Set("0123456789").contains($0)}
                                            if filtered != newValue {
                                                self.birthdate.day = filtered
                                            }
                                        }
                                              ).onReceive(Just(birthdate.day), perform: { _ in
                                                  if birthdate.day.count > 2 {
                                                      birthdate.day = String(birthdate.day.prefix(2))
                                        }
                                    })
                                
                            )
                        
                        Text("YYYY")
                            .foregroundColor(birthdate.year.isEmpty ? Color(red: 70/255, green: 70/255, blue: 73/255) : Color.black)
                            .fontWeight(.heavy)
                            .font(.system(size: 40))
                            .frame(width: 120)
                            .overlay(
                                TextField("", text: $birthdate.year)
                                    .foregroundColor(.white)
                                    .font(.system(size: 45, weight: .heavy))
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.numberPad)
                                    .onReceive(Just(birthdate.year), perform: { newValue in
                                        let filtered = newValue.filter {
                                            Set("0123456789").contains($0)}
                                            if filtered != newValue {
                                                self.birthdate.year = filtered
                                            }
                                        }
                                              ).onReceive(Just(birthdate.year), perform: { _ in
                                                  if birthdate.year.count > 4 {
                                                      birthdate.year = String(birthdate.year.prefix(4))
                                          }
                                      })
                            )
                    }
                    Spacer()
                }
                .padding(.top, 50)
                
                VStack {
                    Spacer()
                    Text("Only to make sure you're old enough to use RealInsights.")
                        .foregroundColor(Color(red: 70/255, green: 70/255, blue: 73/255))
                        .fontWeight(.semibold)
                        .font(.system(size: 14))
                    Button {
                        buttonClicked = true
                    } label: {
                        WhiteButtonView(buttonActive: $buttonActive, text: "Continue")
                            .onChange(of: birthdate.month) { newValue in
                                buttonActive = !newValue.isEmpty
                            }
                    }
                }
            }
        }
    }
}

struct EnterAgeView_Previews: PreviewProvider {
    static var previews: some View {
        EnterAgeView(birthdate: .constant(Birthdate(day: "", month: "", year: "")), name: .constant(""), buttonClicked: .constant(true))
    }
}
