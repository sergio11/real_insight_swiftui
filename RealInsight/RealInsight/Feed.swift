//
//  Feed.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 4/2/24.
//

import SwiftUI

struct Feed: View {
    
    @Binding var mainMenu: String
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ZStack {
                
                ScrollView {
                    VStack {
                        VStack {
                            ZStack {
                                VStack(alignment: .leading) {
                                    Image("example")
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(5)
                                }
                                
                                VStack {
                                    HStack {
                                        Image("example")
                                            .resizable()
                                            .scaledToFit()
                                            .border(.black)
                                            .cornerRadius(2)
                                            .frame(width: 20, height: 40)
                                            .padding(.leading)
                                        Spacer()
                                    }
                                    .padding(.top, 18)
                                    Spacer()
                                }
                                
                                
                            }.frame(width: 100)
                            
                        }
                        
                        VStack {
                            Text("Add a caption...")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                            Text("View comment")
                                .foregroundColor(.gray)
                            
                            HStack {
                                Text("Location * 1 hr late")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                                ThreeDots(size: 3, color: .gray)
                            }
                        }
                        
                        ForEach(1..<8) { _ in
                            FeedCell()
                        }
                        
                    }.padding(.top, 80)
                    
                }
            }
            
            VStack {
                VStack {
                    HStack {
                        
                        Button {
                            withAnimation {
                                self.mainMenu = "left"
                            }
                        } label: {
                            Image(systemName: "person.2.fill")
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        Text("RealInsight.")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 22))
                        Spacer()
                        Button {
                            withAnimation {
                                self.mainMenu = "profile"
                            }
                        } label: {
                            Circle()
                                .frame(width: 35, height: 35)
                                .cornerRadius(17.5)
                                .foregroundColor(Color(red: 152/255, green: 163/255, blue: 16/255))
                                .overlay(
                                    Text(viewModel.currentUser!.fullname.prefix(1).uppercased())
                                        .foregroundColor(.white)
                                        .font(.system(size: 15))
                                )
                        }
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("My friends")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                        
                        Text("Discovery")
                            .foregroundColor(.gray)
                
                    }
                    
                    Spacer()
                    
                    
                }
            }
        }
    }
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed(mainMenu:.constant("feed"))
    }
}
