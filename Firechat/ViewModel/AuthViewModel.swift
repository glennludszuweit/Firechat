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
        guard email != nil else { return false }
        guard pass != nil else { return false }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let isEmailValid = emailPredicate.evaluate(with: email)
        let isPassValid = pass!.count >= 8
        
        if isEmailValid && isPassValid {
            return true
        } else {
            return false
        }
    }
    
    func login(email: String, password: String, coordinator: Coordinator) {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error logging in user: \(error)")
                return
            } else {
                print("Successfully logged in user: \(result?.user.email ?? "")")
                coordinator.isLoggedIn = true
                coordinator.entryScreen()
            }
        }
    }
    
    func register(username: String, email: String, password: String, coordinator: Coordinator) {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error creating user: \(error)")
                return
            } else {
                print("Successfully created user: \(result?.user.email ?? "")")
                coordinator.isLoggedIn = true
                coordinator.entryScreen()
            }
        }
    }
}
