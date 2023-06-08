//
//  UserViewModel.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 07/06/2023.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var user: User?
    
    init() {
        getCurrentUser()
    }
    
    func getCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
//            self.errorMessage = "Could not find firebase uid"
            return
        }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
//                self.errorMessage = "Failed to fetch current user: \(error)"
                print("Failed to fetch current user:", error)
                return
            }
            
            guard let data = snapshot?.data() else {
//                self.errorMessage = "No data found"
                return
            }

            let uid = data["uid"] as? String ?? ""
            let username = data["username"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let image = data["image"] as? String ?? ""
            self.user = User(uid: uid, username: username, email: email, image: image)
        }
    }
}
