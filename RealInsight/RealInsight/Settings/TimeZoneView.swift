//
//  TimeZoneView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 5/2/24.
//

import SwiftUI

struct TimeZoneView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var area = "europe"
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    ZStack {
                        Text("Time Zone")
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
                        }
                    }
                    .padding(.horizontal)
                    Spacer()
                }
                
                
                VStack {
                    
                    VStack {
                        HStack {
                            Text("Select your Time zone")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text("To receive your RealInsight notification during daytime select your time zone. When changing your time zone, your current RealInsight will be deleted. You can only change time zones once a day")
                                .foregroundColor(.white)
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .padding(.top, -8)
                        
                    }
                    
                    
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 14)
                                .frame(width: UIScreen.main.bounds.width * 0.9, height: 190)
                                .foregroundColor(.white)
                                .opacity(0.07)
                            
                            VStack {
                                Button {
                                    self.area = "europe"
                                } label: {
                                    HStack {
                                        Image(systemName: "globe.europe.africa.fill")
                                            .foregroundColor(.white)
                                        
                                        Text("Europe")
                                            .foregroundColor(.white)
                                            .fontWeight(.semibold)
                                        
                                        Spacer()
                                        
                                        if self.area == "europe" {
                                            Image(systemName: "checkmark.circle")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 14))
                                        }
                                        
                                    }
                                    .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                                    .frame(height: 30)
                                }
                                
                                HStack {
                                    Spacer()
                                    Rectangle()
                                        .frame(width: UIScreen.main.bounds.width * 0.8, height: 0.3)
                                        .opacity(0.4)
                                        .foregroundColor(.gray)
                                }
                                
                                Button {
                                    self.area = "americas"
                                } label: {
                                    HStack {
                                        Image(systemName: "globe.europe.africa.fill")
                                            .foregroundColor(.white)
                                        
                                        Text("Americas")
                                            .foregroundColor(.white)
                                            .fontWeight(.semibold)
                                        
                                        Spacer()
                                        
                                        if self.area == "americas" {
                                            Image(systemName: "checkmark.circle")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 14))
                                        }
                                        
                                    }
                                    .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                                    .frame(height: 30)
                                }
                                
                                HStack {
                                    Spacer()
                                    Rectangle()
                                        .frame(width: UIScreen.main.bounds.width * 0.8, height: 0.3)
                                        .opacity(0.4)
                                        .foregroundColor(.gray)
                                }
                                
                                
                                Button {
                                    self.area = "eastasia"
                                } label: {
                                    HStack {
                                        Image(systemName: "globe.europe.africa.fill")
                                            .foregroundColor(.white)
                                        
                                        Text("East Asia")
                                            .foregroundColor(.white)
                                            .fontWeight(.semibold)
                                        
                                        Spacer()
                                        
                                        if self.area == "eastasia" {
                                            Image(systemName: "checkmark.circle")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 14))
                                        }
                                        
                                    }
                                    .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                                    .frame(height: 30)
                                }
                                
                                HStack {
                                    Spacer()
                                    Rectangle()
                                        .frame(width: UIScreen.main.bounds.width * 0.8, height: 0.3)
                                        .opacity(0.4)
                                        .foregroundColor(.gray)
                                }
                                
                                Button {
                                    self.area = "westasia"
                                } label: {
                                    HStack {
                                        Image(systemName: "globe.europe.africa.fill")
                                            .foregroundColor(.white)
                                        
                                        Text("West Asia")
                                            .foregroundColor(.white)
                                            .fontWeight(.semibold)
                                        
                                        Spacer()
                                        
                                        if self.area == "westasia" {
                                            Image(systemName: "checkmark.circle")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 14))
                                        }
                                        
                                    }
                                    .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                                    .frame(height: 30)
                                }
                                
                                HStack {
                                    Spacer()
                                    Rectangle()
                                        .frame(width: UIScreen.main.bounds.width * 0.8, height: 0.3)
                                        .opacity(0.4)
                                        .foregroundColor(.gray)
                                }
                                
                                
                            }
                            
                        }
                        .padding(.top)
                    }
                    
                    
                    Spacer()
                    
                    Button {} label: {
                        RoundedRectangle(cornerRadius: 14)
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: 45)
                            .foregroundColor(Color(red: 86/255, green: 86/255, blue: 88/255))
                            .overlay(
                                Text("Save")
                                    .foregroundColor(.black)
                                    .font(.system(size: 14))
                            )
                    }
                    
                }
                .padding(.top, 50)
                .padding(.horizontal)
                
                
            }
        
        
        }
    }
}

struct TimeZoneView_Previews: PreviewProvider {
    static var previews: some View {
        TimeZoneView()
    }
}
