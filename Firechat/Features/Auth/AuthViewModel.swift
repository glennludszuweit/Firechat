//
//  AuthViewModel.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 05/06/2023.
//

import SwiftUI
import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    func validateUser(email: String?, pass: String?) -> Bool {
        guard pass != nil else { return false }
        let isPassValid = pass!.count >= 8
        
        if validateEmail(email: email) && isPassValid {
            return true
        } else {
            return false
        }
    }
    
    func validateEmail(email: String?) -> Bool {
        guard email != nil else { return false }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isEmailValid = emailPredicate.evaluate(with: email)
        if isEmailValid {
            return true
        } else {
            return false
        }
    }
    
    func login(email: String, password: String, coordinator: Coordinator, alertViewModel: AlertViewModel) {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                alertViewModel.setErrorValues(errorMessage: error.localizedDescription, showAlert: true)
                print(error)
                print(alertViewModel.showAlert)
                return
            } else {
                coordinator.isLoggedIn = true
            }
        }
    }
    
    func logout(coordinator: Coordinator, alertViewModel: AlertViewModel) {
        do {
            try FirebaseManager.shared.auth.signOut()
            coordinator.isLoggedIn = false
        } catch let error {
            alertViewModel.setErrorValues(errorMessage: error.localizedDescription, showAlert: true)
        }
    }
    
    func register(image: UIImage, username: String, email: String, password: String, coordinator: Coordinator, alertViewModel: AlertViewModel) {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                alertViewModel.setErrorValues(errorMessage: error.localizedDescription,  showAlert: true)
                return
            } else {
                self.persistImageToStorage(email: email, username: username, image: image, alertViewModel: alertViewModel)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    coordinator.isLoggedIn = true
                }
            }
        }
    }
    
    func resetPassword(email: String, coordinator: Coordinator, alertViewModel: AlertViewModel) {
        FirebaseManager.shared.auth.sendPasswordReset(withEmail: email) { error in
            if let error = error {
                alertViewModel.setErrorValues(errorMessage: error.localizedDescription, showAlert: true)
                return
            } else {
                coordinator.loginScreen()
            }
        }
    }
    
    private func persistImageToStorage(email: String, username: String, image: UIImage?, alertViewModel: AlertViewModel) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let imageData = image?.jpegData(compressionQuality: 0.5) else { return }
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                alertViewModel.setErrorValues(errorMessage: error.localizedDescription, showAlert: true)
                return
            } else {
                ref.downloadURL { url, error in
                    if let error = error {
                        alertViewModel.setErrorValues(errorMessage: error.localizedDescription, showAlert: true)
                        return
                    } else {
                        self.saveUserToFirestore(uid: uid, email: email, username: username, profileImgUrl: url?.absoluteString ?? "", alertViewModel: alertViewModel)
                    }
                }
            }
        }
    }
    
    private func saveUserToFirestore(uid: String, email: String, username: String, profileImgUrl: String, alertViewModel: AlertViewModel) {
        let userData: [String:Any] = ["uid": uid, "email": email, "username": username, "image": profileImgUrl]
        FirebaseManager.shared.firestore
            .collection("users")
            .document(uid)
            .setData(userData) { error in
                if let error = error {
                    alertViewModel.setErrorValues(errorMessage: error.localizedDescription, showAlert: true)
                    return
                }
            }
    }
}
