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
    @Published var messages: [Message] = []
    @Published var proxyCounter: Int = 0
    
    func getMessages(coordinator: Coordinator, alertViewModel: AlertViewModel) {
        guard let currentUser = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let user = coordinator.user?.uid else { return }
        
        FirebaseManager.shared.firestore
            .collection("messages")
            .document(currentUser)
            .collection(user)
            .order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    alertViewModel.setErrorValues(errorMessage: error.localizedDescription, showAlert: true)
                    return
                }
                
                guard let data = snapshot?.documentChanges else { return }
                
                data.forEach { el in
                    if el.type == .added {
                        let from = el.document["from"] as? String ?? ""
                        let to = el.document["to"] as? String ?? ""
                        let message = el.document["message"] as? String ?? ""
                        let timestamp = el.document["timestamp"] as? Date ?? Date.now
                        let userMessage = Message(id: el.document.documentID, from: from, to: to, message: message, timestamp: timestamp)
                        self.messages.append(userMessage)
                    }
                }
                
                DispatchQueue.main.async {
                    self.proxyCounter += 1
                }
            }
    }
    
    func sendMessage(text: String, coordinator: Coordinator, alertViewModel: AlertViewModel) {
        message = text
        guard let currentUser = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let user = coordinator.user?.uid else { return }
        let data: [String:Any] = [FirebaseConstants.from: currentUser, FirebaseConstants.to: user, FirebaseConstants.message: message, FirebaseConstants.timestamp: Timestamp()]
        
        senderMessageDoc(from: currentUser, to: user, data: data, alertViewModel: alertViewModel)
        recipientMessageDoc(from: user, to: currentUser, data: data, alertViewModel: alertViewModel)
        DispatchQueue.main.async {
            self.proxyCounter += 1
        }
    }
    
    private func senderMessageDoc(from: String, to: String, data: [String : Any], alertViewModel: AlertViewModel) {
        let document = FirebaseManager.shared.firestore.collection("messages").document(from).collection(to).document()
        document.setData(data) { error in
            if let error = error {
                alertViewModel.setErrorValues(errorMessage: error.localizedDescription, showAlert: true)
                return
            }
        }
    }
    
    private func recipientMessageDoc(from: String, to: String, data: [String : Any], alertViewModel: AlertViewModel) {
        let document = FirebaseManager.shared.firestore.collection("messages").document(from).collection(to).document()
        document.setData(data) { error in
            if let error = error {
                alertViewModel.setErrorValues(errorMessage: error.localizedDescription, showAlert: true)
                return
            }
        }
    }
}
