//
//  EditProfile.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 5/2/24.
//

import SwiftUI
import Kingfisher

struct EditProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = EditProfileViewModel()

    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                EditProfileTopBarView(onDismiss: {
                    dismiss()
                }, onSaveData: saveData)
                VStack {
                    ProfilePickerImageView(authUserProfileImageUrl: $viewModel.authUserProfileImageUrl, authUserFullName: $viewModel.authUserFullName, imagePickerPressented: $viewModel.imagePickerPressented, profileImage: $viewModel.profileImage, selectedImage: $viewModel.selectedImage)
                    EditProfileFormView(fields: $viewModel.fields)
                    Spacer()
                }
                .padding(.top, UIScreen.main.bounds.height * 0.08)
            }
        }
        .overlay {
            LoadingView()
                .opacity(viewModel.isLoading ? 1 : 0)
        }
        .onReceive(viewModel.$profileUpdated) { isUpdated in
            if isUpdated {
                dismiss()
            }
        }.onAppear {
            onLoadCurrentUser()
        }
    }
    
    private func saveData() {
        viewModel.saveUserData()
    }
    
    private func onLoadCurrentUser() {
        viewModel.loadCurrentUser()
    }
}

private struct EditProfileTopBarView: View {
    
    var onDismiss = {}
    var onSaveData = {}
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button {
                        onDismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Button {
                        onSaveData()
                    } label: {
                        Text("Save")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                Text("Edit Profile")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
            }
            HStack {
                Spacer()
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 0.7)
                    .foregroundColor(.gray)
                    .opacity(0.5)
            }
            Spacer()
        }
    }
}


private struct EditProfileFormView: View {
    
    @Binding var fields: [FormField]
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 0.7)
                .foregroundColor(.gray)
                .opacity(0.3)
            ForEach(fields.indices, id: \.self) { index in
                EditProfileFieldRow(field: $fields[index])
            }
        }
        .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
        .padding(.top, 24)
    }
}

private struct EditProfileFieldRow: View {
    
    @Binding var field: FormField
    
    var body: some View {
        HStack {
            HStack {
                Text(field.label)
                    .foregroundColor(.white)
                    .font(.system(size: 16))
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width * 0.22)
            HStack {
                if field is TextFormField {
                    TextFormFieldView(textValue: Binding(
                        get: { field.getValue() ?? "" },
                        set: { newValue in field.setValue(newValue) }
                    ), placeholder: field.placeholder)
                } else if field is TextAreaFormField {
                   let fieldBinding = Binding<String>(
                    get: { field.getValue() ?? "" },
                    set: { newValue in field.setValue(newValue)}
                   )
                   if #available(iOS 16, *) {
                       TextEditorFormFieldView(textValue: fieldBinding, placeholder: field.placeholder)
                   } else {
                       TextFormFieldView(textValue: fieldBinding, placeholder: field.placeholder)
                   }
                } else if field is DatePickerFormField {
                    DatePickerFormFieldView(dateValue: Binding<Date>(
                        get: { field.getValue() ?? Date() },
                        set: { newValue in field.setValue(newValue)}
                    ), placeholder: field.placeholder)
                }
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width * 0.63)
        }
        Rectangle()
            .frame(width: UIScreen.main.bounds.width * 0.9, height: 0.7)
            .foregroundColor(.gray)
            .opacity(0.3)
    }
}

private struct TextFormFieldView: View {
    
    @Binding var textValue: String
    var placeholder: String
    
    var body: some View {
        TextField("", text: $textValue)
            .font(.system(size: 16))
            .placeholder(when: textValue.isEmpty) {
                Text(placeholder)
                    .foregroundColor(.white)
                    .font(.system(size: 16))
            }
            .foregroundColor(.white)
            .padding(.leading, UIScreen.main.bounds.width * 0.05)
    }
}


private struct DatePickerFormFieldView: View {
    
    @Binding var dateValue: Date
    var placeholder: String
    
    var body: some View {
        DatePicker("", selection: $dateValue, in: ...Date(), displayedComponents: .date)
        .datePickerStyle(.automatic)
        .foregroundColor(.black)
        .background(Color.white.opacity(0.9).cornerRadius(10))
        .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
        .labelsHidden()
    }
}

private struct TextEditorFormFieldView: View {
    
    @Binding var textValue: String
    var placeholder: String
    
    var body: some View {
        TextEditor(text: $textValue)
            .foregroundColor(.white)
            .background(.black)
            .scrollContentBackground(.hidden)
            .frame(height: 100)
            .padding(.leading, UIScreen.main.bounds.width * 0.05)
            .overlay(
               VStack {
                    HStack {
                        if placeholder.isEmpty {
                             Text(placeholder)
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
            .frame(width: UIScreen.main.bounds.width * 0.63)
    }
}


private struct ProfilePickerImageView: View {
    
    @Binding var authUserProfileImageUrl: String
    @Binding var authUserFullName: String
    @Binding var imagePickerPressented: Bool
    @Binding var profileImage: Image?
    @Binding var selectedImage: UIImage?
    
    var body: some View {
        VStack {
            Button {
                self.imagePickerPressented.toggle()
            } label: {
                ZStack(alignment: .bottomTrailing) {
                    if let image = profileImage  {
                        image
                            .resizable()
                            .frame(width: 120, height: 120)
                            .cornerRadius(60)
                    } else {
                        ProfileImageView(
                            size: 120,
                            cornerRadius: 60,
                            profileImageUrl: authUserProfileImageUrl,
                            fullName: authUserFullName
                        )
                    }
                    IconCircleView(iconName: "camera.fill")
                }
            }
            .sheet(isPresented: $imagePickerPressented) {
                onLoadImage()
            } content: {
                ImagePicker(image: $selectedImage)
            }
        }
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
