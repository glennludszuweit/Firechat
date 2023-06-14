//
//  UserViewModel.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 07/06/2023.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var authUser: User?
    @Published var users: [User] = []
    @Published var messagedUsers: [User] = []
    
    init() {
        getCurrentUser(alertViewModel: AlertViewModel())
        getAllUsers(alertViewModel: AlertViewModel())
    }
    
    func getCurrentUser(alertViewModel: AlertViewModel) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                alertViewModel.setErrorValues(errorMessage: error.localizedDescription, showAlert: true)
                return
            }
            
            guard let data = snapshot?.data() else { return }

            let uid = data["uid"] as? String ?? ""
            let username = data["username"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let image = data["image"] as? String ?? ""
            self.authUser = User(uid: uid, username: username, email: email, image: image)
        }
    }
    
    func getAllUsers(alertViewModel: AlertViewModel) {
        FirebaseManager.shared.firestore.collection("users").getDocuments { snapshot, error in
            if let error = error {
                alertViewModel.setErrorValues(errorMessage: error.localizedDescription, showAlert: true)
                return
            }
            
            guard let data = snapshot?.documents else { return }

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
