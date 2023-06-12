//
//  ChatListView.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 06/06/2023.
//

import SwiftUI

struct ChatListView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var userViewModel: UserViewModel
    @State var shouldShowLogOutOptions: Bool = false
    
    var body: some View {
        if userViewModel.user != nil {
            VStack {
                ChatHeaderView(userViewModel: UserViewModel(), authViewModel: AuthViewModel(), shouldShowLogOutOptions: $shouldShowLogOutOptions)
                ScrollView {
                    ForEach(userViewModel.users, id: \.uid) { user in
                        Button {
                            coordinator.messageLogScreen(user: user)
                        } label: {
                            ChatListCellView(user: user)
                        }
                    }
                }
            }
        } else {
            ProgressView()
        }
    }
}

struct MessagesListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView(userViewModel: UserViewModel())
    }
}
