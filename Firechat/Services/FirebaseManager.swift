//
//  FirebaseManager.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 06/06/2023.
//

import Foundation
import Firebase

class FirebaseManager: NSObject {
    let auth: Auth
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        super.init()
    }
    
}
