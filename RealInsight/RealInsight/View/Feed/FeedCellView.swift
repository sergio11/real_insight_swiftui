//
//  FeedCell.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 4/2/24.
//

import SwiftUI
import Kingfisher

struct FeedCellView: View {
    
    var realInsight: RealInsight
    var blur: Bool
    
    @ObservedObject var viewModel: FeedCellViewModel
    
    init(realInsight: RealInsight, blur: Bool, viewModel: FeedCellViewModel) {
        self.realInsight = realInsight
        self.blur = blur
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            
            Color.black.ignoresSafeArea()
            
            VStack(alignment: .leading) {
                
                HStack {
                    
                    if let userImageUrl = viewModel.realInsight.user?.profileImageUrl {
                        KFImage(URL(string: userImageUrl))
                            .resizable()
                            .frame(width: 40, height: 40)
                            .cornerRadius(20)
                    }
                    else {
                        Circle()
                            .frame(width: 40, height: 40)
                            .cornerRadius(20)
                            .foregroundColor(Color(red: 152/255, green: 163/255, blue: 16/255))
                            .overlay(
                                Text(viewModel.realInsight.username.prefix(1).uppercased())
                                    .foregroundColor(.white)
                                    .font(.system(size: 18))
                            )
                        
                    }
                
                    
                    VStack(alignment: .leading) {
                        
                        if let name = viewModel.realInsight.user?.fullname {
                            Text(name)
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.system(size: 16))
                        }
                        
                        Text("Published 7 hrs late")
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                    }
                    
                    Spacer()
                    
                    ThreeDots(size: 4, color: .gray)
                }.padding(.horizontal)
                
                
                VStack(alignment: .leading) {
                    ZStack {
                        ZStack {
                            
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    VStack {
                                        Image(systemName: "bubble.left.fill")
                                            .foregroundColor(.white)
                                            .font(.system(size: 25))
                                            .shadow(color: .black, radius: 3, x: 1, y: 1)
                                        
                                        Image(systemName: "face.smiling.fill")
                                            .foregroundColor(.white)
                                            .font(.system(size: 25))
                                            .shadow(color: .black, radius: 3, x: 1, y: 1)
                                            .padding(.top, 15)
                                    }
                                    .padding(.trailing, 20)
                                    .padding(.bottom, 50)
                                    
                                }
                            }.zIndex(1)
                            
                            VStack(alignment: .leading) {
                                
                                KFImage(URL(string: realInsight.backImageUrl))
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width)
                                    .scaledToFit()
                                    .cornerRadius(20)
                                
                            }
                            
                            GeometryReader { g in
                                VStack {
                                    HStack {
                                        KFImage(URL(string: realInsight.frontImageUrl))
                                            .resizable()
                                            .frame(width: 100, height: 160)
                                            .scaledToFit()
                                            .cornerRadius(8)
                        
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(.black, lineWidth: 3)
                                            )
                                            .padding(.leading)
                                        Spacer()
                                    }
                                    .padding(.top, 18)
                                    Spacer()
                                }
                            }

                        }.blur(radius: blur ? 8 : 0)
                        
                        if blur {
                            VStack {
                                Image(systemName: "eye.slash.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30))
                                Text("Post to view")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .padding(.top, 4)
                                Text("To view your friends' RealInsight, share yours with them.")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14))
                                    .padding(.top, -4)
                                
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundColor(.white)
                                    .frame(width: 180, height: 40)
                                    .overlay(
                                        Text("Post a Late RealInsight")
                                            .foregroundColor(.black)
                                            .font(.system(size: 12))
                                    )
                                    .padding(.top, 6)
                            }
                        }
                        
                    }
                    
                    Text(blur ? "": "Add a comment...")
                        .foregroundColor(.gray)
                        .fontWeight(.semibold)
                        .padding(.leading)
                        
                }
                
            }
            
        }.frame(width: UIScreen.main.bounds.width, height: 600)
    }
}
