//
//  MessageViewModel.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 08/06/2023.
//

import Foundation
import Firebase

class MessageViewModel: ObservableObject {
    @Published var message: String = ""
    
    private var alertViewModel: AlertViewModel?
    
    func sendMessage(text: String, coordinator: Coordinator, alertViewModel: AlertViewModel) {
        guard let currentUser = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let user = coordinator.user?.uid else { return }
        message = text
        self.alertViewModel = alertViewModel
        senderMessageDoc(data: ["from": currentUser, "to": user, "message": message, "timestamp": Timestamp()])
        recipientMessageDoc(data: ["from": user, "to": currentUser, "message": message, "timestamp": Timestamp()])
    }
    
    private func senderMessageDoc(data: [String : Any]) {
        saveMessage(data: data)
    }
    
    private func recipientMessageDoc(data: [String : Any]) {
        saveMessage(data: data)
    }
    
    private func saveMessage(data: [String : Any]) {
        let document = FirebaseManager.shared.firestore.collection("messages").document(data["from"] as! String).collection(data["to"] as! String).document()
        document.setData(data) { error in
            if let error = error {
                self.alertViewModel?.setErrorValues(errorMessage: error.localizedDescription, showAlert: true)
                return
            } else {
                print("Successfully saved user information.")
            }
        }
    }
}
