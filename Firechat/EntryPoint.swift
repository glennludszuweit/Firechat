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
//            LoginView(authViewModel: AuthViewModel())
            MessagesListView(userViewModel: UserViewModel())
        }
//        .fullScreenCover(isPresented: $coordinator.isLoggedIn) {
//            MessagesListView(userViewModel: UserViewModel())
//        }
    }
}
