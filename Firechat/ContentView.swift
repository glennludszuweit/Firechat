//
//  ContentView.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 05/06/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var alertViewModel: AlertViewModel
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            EntryPoint()
                .navigationDestination(for: CurrentPage.self) { navigation in
                    switch navigation {
                    case .entry:
                        EntryPoint()
                    case .login:
                        LoginView(authViewModel: AuthViewModel())
                    case .register:
                        RegisterView(authViewModel: AuthViewModel())
                    case .repassword:
                        ResetPassView(authViewModel: AuthViewModel())
                    case .chat:
                        MessagesListView(userViewModel: UserViewModel())
                    }
                }
        }.overlay {
            VStack {
                if alertViewModel.showAlert {
                    CustomAlert()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Coordinator())
    }
}
