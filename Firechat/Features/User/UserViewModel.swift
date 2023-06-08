//
//  UserViewModel.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 07/06/2023.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var user: User?
    @Published var users: [User] = []
    
    init() {
        getCurrentUser(alertViewModel: AlertViewModel())
        getAllUsers(alertViewModel: AlertViewModel())
    }
    
    func getCurrentUser(alertViewModel: AlertViewModel) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            alertViewModel.setErrorValues(customError: ErrorHandler.noDataFound, showAlert: true)
            return
        }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                alertViewModel.setErrorValues(customError: ErrorHandler.fetchingError, showAlert: true)
                print("Failed to fetch current user:", error)
                return
            }
            
            guard let data = snapshot?.data() else {
                alertViewModel.setErrorValues(customError: ErrorHandler.noDataFound, showAlert: true)
                return
            }

            let uid = data["uid"] as? String ?? ""
            let username = data["username"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let image = data["image"] as? String ?? ""
            self.user = User(uid: uid, username: username, email: email, image: image)
        }
    }
    
    func getAllUsers(alertViewModel: AlertViewModel) {
        FirebaseManager.shared.firestore.collection("users").getDocuments { snapshot, error in
            if let error = error {
                alertViewModel.setErrorValues(customError: ErrorHandler.noDataFound, showAlert: true)
                print("Failed to fetch users:", error)
                return
            }
            
            guard let data = snapshot?.documents else {
                alertViewModel.setErrorValues(customError: ErrorHandler.noDataFound, showAlert: true)
                return
            }

            data.forEach { el in
                let uid = el["uid"] as? String ?? ""
                let username = el["username"] as? String ?? ""
                let email = el["email"] as? String ?? ""
                let image = el["image"] as? String ?? ""
                let user = User(uid: uid, username: username, email: email, image: image)
                if user.uid != FirebaseManager.shared.auth.currentUser?.uid {
                    self.users.append(user)
                }
            }
        }
    }
}
