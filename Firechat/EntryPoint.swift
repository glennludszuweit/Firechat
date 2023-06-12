//
//  EntryPoint.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 06/06/2023.
//

import SwiftUI

struct EntryPoint: View {
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        VStack {
            if coordinator.isLoggedIn {
                ChatListView(userViewModel: UserViewModel())
            } else {
                LoginView(authViewModel: AuthViewModel())
            }
            
        }
    }
}
