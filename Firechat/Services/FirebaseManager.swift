//
//  FirebaseManager.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 06/06/2023.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage

struct FirebaseConstants {
    static let from = "from"
    static let to = "to"
    static let message = "message"
    static let timestamp = "timestamp"
    static let userImage = "userImage"
    static let userName = "userName"
    static let userEmail = "userEmail"
    static let userId = "userId"
}

class FirebaseManager: NSObject {
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    let crashlytics: Crashlytics
    
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        self.crashlytics = Crashlytics.crashlytics()
        super.init()
    }
}
