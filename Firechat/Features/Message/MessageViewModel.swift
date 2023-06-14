//
//  MessageViewModel.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 08/06/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class MessageViewModel: ObservableObject {
    @Published var message: String = ""
    @Published var messages: [Message] = []
    @Published var recentMessages: [Message] = []
    @Published var proxyCounter: Int = 0
    @Published var snapShotListener: ListenerRegistration?
    
    func getMessages(coordinator: Coordinator, alertViewModel: AlertViewModel) {
        guard let currentUser = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let user = coordinator.user else { return }
        
        snapShotListener = FirebaseManager.shared.firestore
            .collection("messages")
            .document(currentUser)
            .collection(user.uid)
            .order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    alertViewModel.setErrorValues(errorMessage: error.localizedDescription, showAlert: true)
                    return
                }
                
                guard let data = snapshot?.documentChanges else { return }
                
                data.forEach { el in
                    if el.type == .added {
                        do {
                            let newMessage = try el.document.data(as: Message.self)
                            self.messages.append(newMessage)
                        } catch let error {
                            print(error.localizedDescription)
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    self.proxyCounter += 1
                }
            }
    }
    
    func getRecentMessages(coordinator: Coordinator, alertViewModel: AlertViewModel) {
        guard let currentUser = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        snapShotListener = FirebaseManager.shared.firestore
            .collection("recent_messages")
            .document(currentUser)
            .collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    alertViewModel.setErrorValues(errorMessage: error.localizedDescription, showAlert: true)
                    return
                }
                
                guard let data = snapshot?.documentChanges else { return }
                
                data.forEach { el in
                    let docId = el.document.documentID
                    
                    if let index = self.recentMessages.firstIndex(where: { item in
                        return item.id == docId
                    }) {
                        self.recentMessages.remove(at: index)
                    }
                    
                    do {
                        let newMessage = try el.document.data(as: Message.self)
                        self.recentMessages.insert(newMessage, at: 0)
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            }
    }
    
    func sendMessage(text: String, coordinator: Coordinator, alertViewModel: AlertViewModel) {
        message = text
        guard let currentUser = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let user = coordinator.user else { return }
        
        //        let newMessage = Message(from: currentUser, to: user.uid, message: message, timestamp: Date.now, userImage: user.image, userName: user.username, userEmail: user.email, userId: user.uid)
        
        let data: [String:Any] = [FirebaseConstants.from: currentUser, FirebaseConstants.to: user.uid, FirebaseConstants.message: message, FirebaseConstants.timestamp: Timestamp(), FirebaseConstants.userImage: user.image, FirebaseConstants.userName: user.username, FirebaseConstants.userEmail: user.email, FirebaseConstants.userId: user.uid]
        
        senderMessageDoc(from: currentUser, to: user.uid, data: data, alertViewModel: alertViewModel)
        recipientMessageDoc(from: user.uid, to: currentUser, data: data, alertViewModel: alertViewModel)
        saveRecentMessages(currentUser: currentUser, user: user.uid, data: data, alertViewModel: alertViewModel)
        
        DispatchQueue.main.async {
            self.proxyCounter += 1
        }
    }
    
    private func senderMessageDoc(from: String, to: String, data: [String : Any], alertViewModel: AlertViewModel) {
        let document = FirebaseManager.shared.firestore
            .collection("messages")
            .document(from)
            .collection(to)
            .document()
        
        document.setData(data) { error in
            if let error = error {
                alertViewModel.setErrorValues(errorMessage: error.localizedDescription, showAlert: true)
                return
            }
        }
    }
    
    private func recipientMessageDoc(from: String, to: String, data: [String : Any], alertViewModel: AlertViewModel) {
        let document = FirebaseManager.shared.firestore
            .collection("messages")
            .document(from)
            .collection(to)
            .document()
        
        document.setData(data) { error in
            if let error = error {
                alertViewModel.setErrorValues(errorMessage: error.localizedDescription, showAlert: true)
                return
            }
        }
    }
    
    private func saveRecentMessages(currentUser: String, user: String, data: [String:Any], alertViewModel: AlertViewModel) {
        let document = FirebaseManager.shared.firestore
            .collection("recent_messages")
            .document(currentUser)
            .collection("messages")
            .document(user)
        
        document.setData(data) { error in
            if let error = error {
                alertViewModel.setErrorValues(errorMessage: error.localizedDescription, showAlert: true)
                return
            }
        }
    }
}
