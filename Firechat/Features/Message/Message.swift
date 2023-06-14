//
//  Message.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 08/06/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct Message: Codable {
    @DocumentID var id: String?
    let from: String
    let to: String
    let message: String
    let timestamp: Date
    let userImage: String
    let userName: String
    let userEmail: String
    let userId: String
}
