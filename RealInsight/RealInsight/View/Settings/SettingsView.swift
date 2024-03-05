//
//  Settings.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 5/2/24.
//

import SwiftUI
import Kingfisher

struct SettingsView: View {
    
    @State var width = UIScreen.main.bounds.width
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Color.black.ignoresSafeArea()
                    TopBarView()
                    VStack {
                        EditProfileItem()
                        MenuBlockSection(
                            title: "Features",
                            items: [
                                ("calendar", "Memories", AnyView(MemoriesView()))
                            ]
                        )
                        MenuBlockSection(
                            title: "Settings",
                            items: [
                                ("square.and.pencil", "Notifications", AnyView(NotificationsView())),
                                ("globe.europe.africa.fill", "Time Zone: Europe", AnyView(TimeZoneView())),
                                ("hammer.circle", "Others", AnyView(OtherView()))
                            ]
                        )
                        MenuBlockSection(
                            title: "About",
                            items: [
                                ("square.and.arrow.up", "Share RealInsiht", AnyView(OtherView())),
                                ("star", "Star", AnyView(OtherView())),
                                ("lifepreserver", "Help", AnyView(HelpView())),
                                 ("info.circle", "About", AnyView(OtherView()))
                            ]
                        )
                        LogoutButton()
                        AppVersion()
                    }
                    
                }
            }.navigationBarHidden(true)
        }
    }
}

private struct TopBarView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }
                .padding(.leading)
                Spacer()
                Text("Settings")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                Spacer()
            }
            Spacer()
        }
    }
}

private struct AppVersion: View {
    var body: some View {
        Text("Version 0.0.1 (0002) - Production")
            .foregroundColor(.gray)
            .font(.system(size: 12))
            .padding(.top, 12)
    }
}

private struct EditProfileItem: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
        .frame(width: UIScreen.main.bounds.width * 0.9, height: 90)
        .foregroundColor(.white)
        .opacity(0.07)
        .overlay(
            NavigationLink {
                EditProfileView()
                    .navigationBarBackButtonHidden()
            } label: {
                HStack {
                    ProfileImageView(
                        profileImageUrl: viewModel.currentUser?.profileImageUrl,
                        fullName: viewModel.fullName
                    )
                    ProfileNameView()
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                    .padding(.horizontal, 18)
            }
            
        )
    }
}

private struct ProfileNameView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.fullName)
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .font(.system(size: 18))
            
            Text(viewModel.username)
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .font(.system(size: 14))
        }
    }
}

private struct LogoutButton: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 45)
                .foregroundColor(.white)
                .opacity(0.07)
            
            HStack {
                Spacer()
                Button {
                    viewModel.signOut()
                } label: {
                    Text("Log out")
                        .foregroundColor(.red)
                }
                Spacer()
            }
            .padding(.horizontal, UIScreen.main.bounds.width * 0.1)
            .frame(height: 30)
        }
        .padding(.top, 12)
    }
}

private struct MenuBlockSection<Destination: View>: View {
    var title: String
    var items: [(imageName: String, title: String, destination: Destination)]
    
    var body: some View {
        VStack(spacing: 6) {
            HStack {
                Text(title.uppercased())
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)
                    .font(.system(size: 12))
                    .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                Spacer()
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: CGFloat(40 * items.count + 10))
                    .foregroundColor(.white)
                    .opacity(0.07)
                
                VStack {
                    ForEach(items.indices, id: \.self) { index in
                            NavigationLink(destination: items[index].destination.navigationBarBackButtonHidden()) {
                                NavigationRow(imageName: items[index].imageName, title: items[index].title)
                            }
                            
                            if index != items.indices.last {
                                Rectangle()
                                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 0.3)
                                    .opacity(0.4)
                                    .foregroundColor(.gray)
                            }
                        }
                }.frame(height: 40)
            }
        }
        .padding(.top, 12)
    }
}

private struct NavigationRow: View {
    let imageName: String
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(.white)
            
            Text(title)
                .foregroundColor(.white)
                .fontWeight(.semibold)
            
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .font(.system(size: 14))
        }
        .padding(.horizontal, UIScreen.main.bounds.width * 0.1)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(AuthenticationViewModel.shared)
    }
}
