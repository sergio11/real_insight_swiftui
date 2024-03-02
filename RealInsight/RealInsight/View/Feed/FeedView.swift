//
//  Feed.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 4/2/24.
//

import SwiftUI
import Kingfisher

struct FeedView: View {
    
    @Binding var mainMenu: String
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    @ObservedObject var feedViewModel: FeedViewModel
    
    @State private var cameraViewPressented: Bool = false
    
    init(feedViewModel: FeedViewModel, menu: Binding<String>) {
        self.feedViewModel = feedViewModel
        self._mainMenu = menu
    }
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ZStack {
                    
                    ScrollView {
                        VStack {
                            
                            if !feedViewModel.blur {
                                VStack {
                                        VStack {
                                            ZStack {
                                                VStack(alignment: .leading) {
                                                    
                                                    
                                                    KFImage(URL(string: feedViewModel.realInsight.backImageUrl))
                                                        .resizable()
                                                        .scaledToFit()
                                                        .cornerRadius(5)
                                                    
                                                }
                                                
                                                VStack {
                                                    HStack {
                                                        KFImage(URL(string: feedViewModel.realInsight.frontImageUrl))
                                                            .resizable()
                                                            .frame(width: 20, height: 40)
                                                            .scaledToFit()
                                                            .border(.black)
                                                            .cornerRadius(2)
                                                            .padding(.leading, 5)
                                                        Spacer()
                                                    }
                                                    .padding(.top, 10)
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
                                }
                            }
                            
                            ForEach(self.feedViewModel.realInsightList, id: \.backImageUrl) { realInsight in
                                FeedCellView(realInsight: realInsight, blur: feedViewModel.blur, viewModel: FeedCellViewModel(realInsight: realInsight))
                                    .onAppear {
                                        if(feedViewModel.blur) {
                                            feedViewModel.blur = realInsight.userId != authViewModel.userUuid
                                        }
                                    }
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
                                
                                if let profileImageUrl = authViewModel.currentUser?.profileImageUrl {
                                    KFImage(URL(string: profileImageUrl))
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .cornerRadius(17.5)
                                } else {
                                    Circle()
                                        .frame(width: 35, height: 35)
                                        .cornerRadius(17.5)
                                        .foregroundColor(Color(red: 152/255, green: 163/255, blue: 16/255))
                                        .overlay(
                                            Text(authViewModel.currentUser!.fullname.prefix(1).uppercased())
                                                .foregroundColor(.white)
                                                .font(.system(size: 15))
                                        )
                                }
                                
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
                        
                        if feedViewModel.blur {
                            
                            HStack {
                                VStack {
                                    Image(systemName: "circle")
                                        .font(.system(size: 80))
                                    Text("Post a late RealInsight.")
                                        .font(.system(size: 14))
                                        .fontWeight(.bold)
                                }
                                .foregroundColor(.white)
                                .padding(.bottom, 12)
                                .onTapGesture {
                                    self.cameraViewPressented.toggle()
                                }
                            }
                        }
                    }
                    .shadow(color: .black.opacity(0.2), radius: 2, x: 1, y: 1)
                }
            }
        }.fullScreenCover(isPresented: $cameraViewPressented) {
            Task { await feedViewModel.fetchData() }
        } content: {
            CameraView(viewModel: CameraViewModel.init(user: authViewModel.currentUser!))
        }
    }
}
