//
//  ChatListView.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 06/06/2023.
//

import SwiftUI

struct ChatListView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var alertViewModel: AlertViewModel
    @StateObject var userViewModel: UserViewModel
    @StateObject var messageViewModel: MessageViewModel
    @State var shouldShowLogOutOptions: Bool = false
    
    var body: some View {
        if userViewModel.authUser != nil {
            VStack {
                ChatHeaderView(alertViewModel: alertViewModel, userViewModel: UserViewModel(), authViewModel: AuthViewModel(), messageViewModel: messageViewModel, shouldShowLogOutOptions: $shouldShowLogOutOptions)
                ScrollView {
                    ForEach(messageViewModel.recentMessages, id: \.id) { message in
                        Button {
                            coordinator.messageLogScreen(user: User(uid: message.userId, username: message.userName, email: message.userEmail, image: message.userImage))
                        } label: {
                            ChatListCellView(message: message)
                        }
                    }
                }
            }.navigationBarBackButtonHidden()
                .onAppear {
                    messageViewModel.getRecentMessages(coordinator: coordinator, alertViewModel: alertViewModel)
                }
                .refreshable {
                    messageViewModel.getRecentMessages(coordinator: coordinator, alertViewModel: alertViewModel)
                }
        } else {
            ProgressView().navigationBarBackButtonHidden()
        }
    }
}

struct MessagesListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView(alertViewModel: AlertViewModel(), userViewModel: UserViewModel(), messageViewModel: MessageViewModel())
    }
}
