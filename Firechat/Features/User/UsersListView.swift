//
//  UsersListView.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 08/06/2023.
//

import SwiftUI

struct UsersListView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var alertViewModel: AlertViewModel
    @StateObject var userViewModel: UserViewModel
    @StateObject var messageViewModel: MessageViewModel
    @Binding var showUsers: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Select Contact").foregroundColor(Color("DarkOrange")).padding(20)
                Spacer()
                Image(systemName: "xmark").font(.system(size: 20))
                    .padding(20)
                    .onTapGesture {
                        showUsers = false
                    }
            }
            ScrollView {
                ForEach(userViewModel.users, id: \.uid) { user in
                    Button {
                        showUsers = false
                        coordinator.messageLogScreen(user: user)
                    } label: {
                        UsersListCellView(user: user)
                    }

                }
            }
        }
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView(alertViewModel: AlertViewModel(), userViewModel: UserViewModel(), messageViewModel: MessageViewModel(), showUsers: .constant(true))
    }
}
