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
    @Published var isLoading: Bool = false
    @Published var verificationCode: String = ""
    @Published var errorMessage = ""
    @Published var showAlert = false
    @Published var currentUser: User?
    
    private var userSession: Firebase.User?
    
    static let shared = AuthenticationViewModel()
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func hasSession() -> Bool {
        return userSession != nil
    }
    
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
                self.currentUser = User(name: name, date: birthdate.date)
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
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        Firestore
            .firestore()
            .collection("users")
            .document(uid)
            .getDocument { sp, err in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                
                guard let user = try? sp?.data(as: User.self) else { return }
                self.currentUser = user
            
        }
    }
    
    private func handleError(error: String) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.errorMessage = error
            self.showAlert.toggle()
        }
    }
}
