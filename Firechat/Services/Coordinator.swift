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
    
    func loginScreen() {
        navigationPath.append(CurrentPage.login)
    }
    
    func registerScreen() {
        navigationPath.append(CurrentPage.register)
    }
}

enum CurrentPage {
    case login
    case register
}
