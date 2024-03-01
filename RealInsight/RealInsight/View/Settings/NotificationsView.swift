//
//  NotificationsView.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 13/2/24.
//

import SwiftUI

struct NotificationsView: View {
    
    @State var mentions = false
    @State var comments = false
    @State var friendRequests = false
    @State var lateRealInsight = false
    @State var realMojis = false
    @State var buttonActive = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    ZStack {
                        Text("Notifications")
                            .fontWeight(.semibold)
                        HStack {
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "arrow.backward")
                                    .font(.system(size: 20))
                            }
                            Spacer()
                        }
                    }.padding(.horizontal)
                    Spacer()
                }
                .foregroundColor(.white)
                
                VStack {
                    VStack {
                        
                        HStack {
                            Text("On RealInsight, you're in control of your push notifications")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        
                        HStack {
                            Text("You can chosse the type of notifications you want to receive")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    
                    VStack(spacing: 14) {
                        
                        VStack {
                            NotificationsButtonView(icon: "person.crop.square.filled.and.at.rectangle", text: "Mentions", toggle: $mentions)
                            
                            HStack {
                                Text("dilaysila mentioned you on seanlud's RealInsight")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                                    .padding(.leading)
                                Spacer()
                            }
                        }
                        
                        VStack {
                            NotificationsButtonView(icon: "bubble.left.fill", text: "Comments", toggle: $comments)
                            
                            HStack {
                                Text("ercimmiyal commented on you RealInsight")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                                    .padding(.leading)
                                Spacer()
                            }
                        }
                        
                        VStack {
                            NotificationsButtonView(icon: "person.2.fill", text: "Friend Request", toggle: $friendRequests)
                            
                            HStack {
                                Text("ercimmiyal just sent you a friend request")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                                    .padding(.leading)
                                Spacer()
                            }
                        }
                        
                        VStack {
                            NotificationsButtonView(icon: "timer", text: "Late RealInsight", toggle: $lateRealInsight)
                            
                            HStack {
                                Text("zeymustu just posted late")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                                    .padding(.leading)
                                Spacer()
                            }
                        }
                        
                        VStack {
                            NotificationsButtonView(icon: "face.smiling.fill", text: "RealMojis", toggle: $realMojis)
                            
                            HStack {
                                Text("ogulcansatafoglu just reacted to your RealInsight")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                                    .padding(.leading)
                                Spacer()
                            }
                        }
                        
                    }
                    .padding(.top, 8)

                    Spacer()
                    
                }
                .padding(.horizontal)
                .padding(.top, 50)
            
                VStack {
                    Spacer()
                    WhiteButtonView(buttonActive: $buttonActive, text: "Save")
                        .onChange(of: mentions || comments || friendRequests || friendRequests || lateRealInsight || realMojis) { _ in
                            self.buttonActive = true
                        }
                }
            }
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
