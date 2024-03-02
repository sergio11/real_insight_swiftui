//
//  AuthenticationViewModel.swift
//  RealInsight
//
//  Created by Sergio Sánchez Sánchez on 28/2/24.
//

import SwiftUI
import Firebase

class AuthenticationViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var birthdate = Birthdate(day: "", month: "", year: "")
    @Published var country: Country = Country(isoCode: "US")
    @Published var phoneNumber = ""
    @Published var otpText = ""
    @Published var navigationTag: String?
    @Published var verificationCode: String = ""
    @Published var errorMessage = ""
    @Published var showAlert = false
    @Published var currentUser: User?
    @Published var isLoading: Bool = false
    @Published var hasSession = false
    
    private var userSession: Firebase.User?
    
    static let shared = AuthenticationViewModel()
    
    var userUuid: String {
        guard let user = currentUser else { return "" }
        return user.id ?? ""
    }
    
    var username: String {
        guard let user = currentUser else { return "" }
        return user.username ?? user.fullname.lowercased()
    }
    
    var fullName: String {
        guard let user = currentUser else { return "" }
        return user.fullname
    }
    
    
    func sendOtp() async {
        print("sendOtp isLoading: \(isLoading) CALLED!")
        guard !isLoading else {
            return
        }
        do {
            onLoading()
            let result = try await PhoneAuthProvider.provider().verifyPhoneNumber("+\(country.phoneCode)\(phoneNumber)", uiDelegate: nil)
            print("sendOtp result \(result) CALLED!")
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.isLoading = false
                self.verificationCode = result
                self.navigationTag = "VERIFICATION"
            }
        } catch {
            print("sendOtp handleError \(error.localizedDescription) CALLED!")
            handleError(error: error)
        }
    }
    
    func verifyOtp() async {
        do {
            onLoading()
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationCode, verificationCode: otpText)
            let result = try await Auth.auth().signIn(with: credential)
            let db = Firestore.firestore()
            db.collection("users").document(result.user.uid).setData([
                "fullname": name,
                "date": birthdate.date,
                "id": result.user.uid,
                "phone": "+\(country.phoneCode)\(phoneNumber)"
            ]) { err in
                if let err = err {
                    print(err.localizedDescription)
                }
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.isLoading = false
                let user = result.user
                self.userSession = user
                self.currentUser = User(fullname: name, date: birthdate.date, phone: "+\(country.phoneCode)\(phoneNumber)")
                self.hasSession = true
                print(user.uid)
            }
        }
        catch {
            print("ERROR")
            handleError(error: error)
        }
    }
    
    func signOut() {
        self.userSession = nil
        try? Auth.auth().signOut()
    }
    
    func verifySession() async {
        onLoading()
        guard let userSession = Auth.auth().currentUser else {
            onNotActiveSessionFound()
            return
        }
        self.userSession = userSession
        Firestore
            .firestore()
            .collection("users")
            .document(userSession.uid)
            .getDocument { [weak self] sp, err in
                guard let self = self else { return }
                if let err = err {
                    print(err.localizedDescription)
                    self.onNotActiveSessionFound()
                    return
                }
                
                guard let user = try? sp?.data(as: User.self) else {
                    self.onNotActiveSessionFound()
                    return
                }
                self.onActiveSessionFound(user: user)
            }
    }
    
    func saveUserData(fullname: String, username: String?, location: String?, bio: String?, selectedImage: UIImage?) async {
        guard let userId = userSession?.uid else { return }
        
        var userData: [String: Any] = [
            UserField.fullname: fullname,
            UserField.username: username ?? "",
            UserField.location: location ?? "",
            UserField.bio: bio ?? ""
        ]
        
        if let image = selectedImage {
            uploadProfileImage(image: image) { [weak self] url in
                userData[UserField.profileImageUrl] = url
                self?.uploadProfileData(userId: userId, data: userData)
            }
        } else {
            uploadProfileData(userId: userId, data: userData)
        }
    }
    
    private func uploadProfileData(userId: String, data: [String: Any]) {
        uploadProfileData(userId: userId, data: data) { [weak self] in
            self?.updateUI { vm in
                vm.currentUser?.fullname = data[UserField.fullname] as? String ?? ""
                vm.currentUser?.username = data[UserField.username] as? String
                vm.currentUser?.location = data[UserField.location] as? String
                vm.currentUser?.bio = data[UserField.bio] as? String
                vm.currentUser?.profileImageUrl = data[UserField.profileImageUrl] as? String
            }
        } onError: { [weak self] error in
            self?.handleError(error: error)
        }
    }
    
    private func uploadProfileImage(image: UIImage, completion: @escaping(String) -> Void) {
        ImageUploader.uploadImage(image: image, type: .profile) { url in
            completion(url)
        }
    }
    
    private func uploadProfileData(userId: String, data: [AnyHashable: Any], onSuccess: @escaping() -> Void, onError: @escaping(Error) -> Void) {
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .updateData(data) { err in
                if let err = err {
                    onError(err)
                    return
                }
                onSuccess()
            }
    }

    private func onLoading() {
        updateUI { vm in
            vm.isLoading = true
        }
    }

    private func onNotActiveSessionFound() {
        updateUI { vm in
            vm.isLoading = false
            vm.hasSession = false
        }
    }

    private func onActiveSessionFound(user: User) {
        updateUI { vm in
            vm.isLoading = false
            vm.hasSession = true
            vm.currentUser = user
        }
    }

    private func handleError(error: Error) {
        print(error.localizedDescription)
        updateUI { vm in
            vm.isLoading = false
            vm.errorMessage = error.localizedDescription
            vm.showAlert.toggle()
        }
    }
    
    private func updateUI(with updates: @escaping (AuthenticationViewModel) -> Void) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            updates(self)
        }
    }
}

private struct UserField {
    static let fullname = "fullname"
    static let username = "username"
    static let location = "location"
    static let bio = "bio"
    static let profileImageUrl = "profileImageUrl"
}
