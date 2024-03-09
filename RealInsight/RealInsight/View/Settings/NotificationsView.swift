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
                TopBarView(backButtonAction: {
                    dismiss()
                }, title: "Notifications")
                VStack {
                    MainTitleTextView()
                    MainMenuOptions(mentions: $mentions, comments: $comments, friendRequests: $friendRequests, lateRealInsight: $lateRealInsight, realMojis: $realMojis, buttonActive: $buttonActive)
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

private struct MainMenuOptions: View {
    
    @Binding var mentions: Bool
    @Binding var comments: Bool
    @Binding var friendRequests: Bool
    @Binding var lateRealInsight: Bool
    @Binding var realMojis: Bool
    @Binding var buttonActive: Bool
    
    var body: some View {
        VStack(spacing: 14) {
            
            NotificationListItem(
                iconName: "person.crop.square.filled.and.at.rectangle",
                text: "Mentions",
                exampleText: "dilaysila mentioned you on seanlud's RealInsight",
                toggle: $mentions
            )
            
            NotificationListItem(
                iconName: "bubble.left.fill",
                text: "Comments",
                exampleText: "ercimmiyal commented on you RealInsight",
                toggle: $comments
            )
            
            NotificationListItem(
                iconName: "person.2.fill",
                text: "Friend Request",
                exampleText: "ercimmiyal just sent you a friend request",
                toggle: $friendRequests
            )
            
            NotificationListItem(
                iconName: "timer",
                text: "Late RealInsight",
                exampleText: "zeymustu just posted late",
                toggle: $lateRealInsight
            )
            
            NotificationListItem(
                iconName: "face.smiling.fill",
                text: "RealMojis",
                exampleText: "ogulcansatafoglu just reacted to your RealInsight",
                toggle: $realMojis
            )
        }
        .padding(.top, 8)
    }
}

private struct MainTitleTextView: View {
    var body: some View {
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
    }
}


private struct NotificationListItem: View {
    var iconName: String
    var text: String
    var exampleText: String
    @Binding var toggle: Bool
    
    var body: some View {
        VStack {
            NotificationsButtonView(icon: iconName, text: text, toggle: $toggle)
            HStack {
                Text(exampleText)
                    .foregroundColor(.gray)
                    .font(.system(size: 12))
                    .padding(.leading)
                Spacer()
            }
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
