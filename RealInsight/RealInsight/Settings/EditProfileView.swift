//
//  EditProfile.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 5/2/24.
//

import SwiftUI
import Kingfisher

struct EditProfileView: View {
    
    @State private var width = UIScreen.main.bounds.width
    @State private var fullname: String = ""
    @State private var username: String = ""
    @State private var bio: String = ""
    @State private var location: String = ""
    @State private var imagePickerPressented = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthenticationViewModel

    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    ZStack {
                        HStack {
                            
                            Button {
                                dismiss()
                            } label: {
                                Text("Cancel")
                                    .foregroundColor(.white)
                            }
                            
                            Spacer()
                            
                            Button {
                                saveData()
                                dismiss()
                            } label: {
                                Text("Save")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal, width * 0.05)
                        
                        Text("Edit Profile")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                    
                    HStack {
                        Spacer()
                        Rectangle()
                            .frame(width: width * 0.9, height: 0.7)
                            .foregroundColor(.gray)
                            .opacity(0.5)
                    }
                    Spacer()
                    
                }
                
                VStack {
                    
                    VStack{
                        Button {
                            self.imagePickerPressented.toggle()
                        } label: {
                            ZStack(alignment: .bottomTrailing) {
                                
                                if profileImage == nil, let profileImageUrl = viewModel.currentUser?.profileImageUrl {
                                    KFImage(URL(string: profileImageUrl))
                                        .resizable()
                                        .frame(width: 120, height: 120)
                                        .cornerRadius(60)
                                    
                                }
                                else if let image = profileImage  {
                                    image
                                        .resizable().frame(width: 120, height: 120)
                                        .cornerRadius(60)
                                } else {
                                    Circle()
                                        .frame(width: 120, height: 120)
                                        .cornerRadius(60)
                                        .foregroundColor(Color(red: 152/255, green: 163/255, blue: 16/255))
                                        .overlay(
                                            Text(viewModel.fullName.prefix(1).uppercased())
                                                .foregroundColor(.white)
                                                .font(.system(size: 55))
                                        )
                                }
                                
                                ZStack {
                                    ZStack {
                                        Circle()
                                            .frame(width: 34, height: 34)
                                            .foregroundColor(.black)
                                        Circle()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.white)
                                        Circle()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.black)
                                            .opacity(0.1)
                                    }
                                    
                                    Image(systemName: "camera.fill")
                                        .foregroundColor(.black)
                                        .font(.system(size: 16))
                                        .shadow(color: .white, radius: 1, x: 1, y: 1)
                                }
                            }
                        }
                        .sheet(isPresented: $imagePickerPressented) {
                            onLoadImage()
                        } content: {
                            ImagePicker(image: $selectedImage)
                        }
                    }
                    
                    VStack {
                        Rectangle()
                            .frame(width: width * 0.9, height: 0.7)
                            .foregroundColor(.gray)
                            .opacity(0.3)
                        
                        HStack {
                            HStack {
                                Text("Full name")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16))
                                Spacer()
                            }
                            .frame(width: width * 0.22)
                            
                            
                            HStack {
                                TextField("", text: $fullname)
                                    .font(.system(size: 16))
                                    .placeholder(when: fullname.isEmpty) {
                                        Text("Name").foregroundColor(.white).font(.system(size: 16))
                                    }
                                    .foregroundColor(.white)
                                    .padding(.leading, width * 0.05)
                                Spacer()
                            }
                            .frame(width: width * 0.63)
                            
                        }
                        
                        Rectangle()
                            .frame(width: width * 0.9, height: 0.7)
                            .foregroundColor(.gray)
                            .opacity(0.3)
                        
                        HStack {
                            HStack {
                                Text("Username")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16))
                                Spacer()
                            }
                            .frame(width: width * 0.22)
                            
                            
                            HStack {
                                TextField("", text: $username)
                                    .font(.system(size: 16))
                                    .placeholder(when: username.isEmpty) {
                                        Text("Username")
                                            .foregroundColor(.white).font(.system(size: 16))
                                    }
                                    .foregroundColor(.white)
                                    .padding(.leading, width * 0.05)
                                Spacer()
                            }
                            .frame(width: width * 0.63)
                            
                        }
                        
                        Rectangle()
                            .frame(width: width * 0.9, height: 0.7)
                            .foregroundColor(.gray)
                            .opacity(0.3)
                        
                        HStack(alignment: .top) {
                            HStack {
                                Text("Bio")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16))
                                Spacer()
                            }
                            .padding(.leading, -4)
                            .frame(width: width * 0.2)
                            
                            if #available(iOS 16, *) {
                                TextEditor(text: $bio)
                                    .foregroundColor(.white)
                                    .background(.black)
                                    .scrollContentBackground(.hidden)
                                    .frame(height: 100)
                                    .padding(.leading, width * 0.05)
                                    .overlay(
                                        VStack {
                                            HStack {
                                                if bio.isEmpty {
                                                    Text("Bio")
                                                        .foregroundColor(.gray)
                                                        .font(.system(size: 16))
                                                        .zIndex(1)
                                                        .padding(.top, 8)
                                                }
                                                Spacer()
                                            }
                                            Spacer()
                                        }
                                    )
                                    .padding(.top, -8)
                                    .frame(width: width * 0.63)
                            }
                        }
                        
                        Rectangle()
                            .frame(width: width * 0.9, height: 0.7)
                            .foregroundColor(.gray)
                            .opacity(0.3)
                        
                        HStack {
                            HStack {
                                Text("Location")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16))
                                Spacer()
                            }
                            .frame(width: width * 0.22)
                            
                            
                            HStack {
                                TextField("", text: $location)
                                    .font(.system(size: 16))
                                    .placeholder(when: location.isEmpty) {
                                        Text("Location").foregroundColor(.white).font(.system(size: 16))
                                    }
                                    .foregroundColor(.white)
                                    .padding(.leading, width * 0.05)
                                Spacer()
                            }
                            .frame(width: width * 0.63)
                            
                        }
                        
                    }
                    .padding(.horizontal, width * 0.05)
                    .padding(.top, 24)
                    
                    Spacer()
                }
                .padding(.top, UIScreen.main.bounds.height * 0.08)
                
            }
        }.onAppear {
            initData()
        }
    }
    
    private func initData() {
        guard let user = viewModel.currentUser else { return }
        self.fullname = user.fullname
        self.username = user.username ?? ""
        self.bio = user.bio ?? ""
        self.location = user.location ?? ""
    }
    
    private func saveData() {
        Task { await viewModel.saveUserData(fullname: fullname, username: username, location: location, bio: bio, selectedImage: selectedImage) }
    }
    
    private func onLoadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
    
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}