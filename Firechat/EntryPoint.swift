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
                ChatListView(alertViewModel: AlertViewModel(), userViewModel: UserViewModel(), messageViewModel: MessageViewModel())
            } else {
                LoginView(alertViewModel: AlertViewModel(), authViewModel: AuthViewModel())
            }
            
            Button("Crash") {
              fatalError("Crash was triggered")
            }
        }
    }
}
