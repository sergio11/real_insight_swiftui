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
    
    
    func sendOtp() async {
        print("sendOtp isLoading: \(isLoading) CALLED!")
        guard !isLoading else {
            return
        }
        do {
            isLoading = true
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
            handleError(error: error.localizedDescription)
        }
    }
    
    func verifyOtp() async {
        do {
            isLoading = true
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationCode, verificationCode: otpText)
            let result = try await Auth.auth().signIn(with: credential)
            let db = Firestore.firestore()
            db.collection("users").document(result.user.uid).setData([
                "fullname": name,
                "date": birthdate.date,
                "id": result.user.uid
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
                self.currentUser = User(fullname: name, date: birthdate.date)
                print(user.uid)
            }
        }
        catch {
            print("ERROR")
            handleError(error: error.localizedDescription)
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
    
    func saveUserData(fullname: String, username: String?, location: String?, bio: String?) async {
        guard let userId = userSession?.uid else { return }
        do {
            try await Firestore.firestore()
                .collection("users")
                .document(userId)
                .updateData([
                    "fullname": fullname,
                    "username": username ?? "",
                    "location": location ?? "",
                    "bio": bio ?? ""
                ])
            updateUI { vm in
                vm.currentUser?.fullname = fullname
                vm.currentUser?.username = username
                vm.currentUser?.location = location
                vm.currentUser?.bio = bio
            }
        }
        catch {
            handleError(error: error.localizedDescription)
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

    private func handleError(error: String) {
        print(error)
        updateUI { vm in
            vm.isLoading = false
            vm.errorMessage = error
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
