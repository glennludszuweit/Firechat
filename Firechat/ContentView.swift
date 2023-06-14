//
//  ContentView.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 05/06/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var alertViewModel: AlertViewModel
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            EntryPoint()
                .navigationDestination(for: CurrentPage.self) { navigation in
                    switch navigation {
                    case .entry:
                        EntryPoint()
                    case .login:
                        LoginView(alertViewModel: AlertViewModel(), authViewModel: AuthViewModel())
                    case .register:
                        RegisterView(alertViewModel: AlertViewModel(), authViewModel: AuthViewModel())
                    case .repassword:
                        ResetPassView(alertViewModel: AlertViewModel(), authViewModel: AuthViewModel())
                    case .chat:
                        ChatListView(alertViewModel: AlertViewModel(), userViewModel: UserViewModel(), messageViewModel: MessageViewModel())
                    case .message:
                        MessageLogView(messageViewModel: MessageViewModel(), alertViewModel: AlertViewModel(), userViewModel: UserViewModel())
                    }
                }
        }.overlay {
            VStack {
                if alertViewModel.showAlert {
                    CustomAlert(alertViewModel: AlertViewModel())
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(alertViewModel: AlertViewModel()).environmentObject(Coordinator())
    }
}
