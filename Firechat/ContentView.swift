//
//  ContentView.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 05/06/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            LoginView()
                .navigationDestination(for: CurrentPage.self) { navigation in
                    switch navigation {
                    case .login:
                        LoginView()
                    case .register:
                        RegisterView()
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
