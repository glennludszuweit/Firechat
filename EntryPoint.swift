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
                ChatView()
            } else {
                LoginView(authViewModel: AuthViewModel())
            }
        }.navigationBarBackButtonHidden(true)
    }
}