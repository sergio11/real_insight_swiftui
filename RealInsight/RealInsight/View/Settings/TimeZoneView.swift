//
//  TimeZoneView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 5/2/24.
//

import SwiftUI

struct TimeZoneView: View {
    @State var area = "europe"
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                TopBarView()
                VStack {
                    VStack {
                        MainTitleTextView()
                        MainDescriptionTextView()
                    }
                    
                    MainMenuOptions(selectedArea: $area)
                    Spacer()
                    MainButton()
                }
                .padding(.top, 50)
                .padding(.bottom, 40)
                .padding(.horizontal)
            }
        }
    }
}

private struct TopBarView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
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
    }
}

private struct MainTitleTextView: View {
    var body: some View {
        HStack {
            Text("Select your Time zone")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.system(size: 20))
            Spacer()
        }
    }
}

private struct MainDescriptionTextView: View {
    var body: some View {
        HStack {
            Text("To receive your RealInsight notification during daytime select your time zone. When changing your time zone, your current RealInsight will be deleted. You can only change time zones once a day")
                .foregroundColor(.white)
                .font(.system(size: 14))
                .fontWeight(.semibold)
            Spacer()
        }
        .padding(.top, -8)
    }
}


private struct MainMenuOptions: View {
    
    @Binding var selectedArea: String
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 190)
                    .foregroundColor(.white)
                    .opacity(0.07)
                
                VStack {
                    AreaSelectionButton(
                        areaName: "europe",
                        areaDescription: "Europe",
                        selectedArea: $selectedArea
                    )
                    AreaSelectionButton(
                        areaName: "americas",
                        areaDescription: "Americas",
                        selectedArea: $selectedArea
                    )
                    AreaSelectionButton(
                        areaName: "eastasia",
                        areaDescription: "East Asia",
                        selectedArea: $selectedArea
                    )
                    AreaSelectionButton(
                        areaName: "westasia",
                        areaDescription: "West Asia",
                        selectedArea: $selectedArea
                    )
                }
            }
            .padding(.top)
        }
        
    }
}

private struct MainButton: View {
    var body: some View {
        Button {
            
        } label: {
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
}

private struct AreaSelectionButton: View {
    
    var areaName: String
    var areaDescription: String
    @Binding var selectedArea: String
    
    var body: some View {
        Button {
            selectedArea = areaName
        } label: {
            HStack {
                Image(systemName: "globe.europe.africa.fill")
                    .foregroundColor(.white)
                
                Text(areaDescription)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                
                Spacer()
                
                if selectedArea == areaName {
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

struct TimeZoneView_Previews: PreviewProvider {
    static var previews: some View {
        TimeZoneView()
    }
}
