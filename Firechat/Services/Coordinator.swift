//
//  Coordinator.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 05/06/2023.
//

import Foundation
import SwiftUI

class Coordinator: ObservableObject {
    @Published var navigationPath = NavigationPath()
    @Published var isLoggedIn: Bool = false
    
    func entryScreen() {
        navigationPath.append(CurrentPage.entry)
    }
    
    func loginScreen() {
        navigationPath.append(CurrentPage.login)
    }
    
    func registerScreen() {
        navigationPath.append(CurrentPage.register)
    }
    
    func repasswordScreen() {
        navigationPath.append(CurrentPage.repassword)
    }
    
    func chatScreen() {
        navigationPath.append(CurrentPage.chat)
    }
}

enum CurrentPage {
    case entry
    case login
    case register
    case repassword
    case chat
}
