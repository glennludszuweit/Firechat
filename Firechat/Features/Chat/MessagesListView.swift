//
//  MessagesListView.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 06/06/2023.
//

import SwiftUI

struct MessagesListView: View {
    @StateObject var userViewModel: UserViewModel
    @State var shouldShowLogOutOptions: Bool = false
    
    var body: some View {
        if userViewModel.user != nil {
            VStack {
                MessagesHeaderView(userViewModel: UserViewModel(), authViewModel: AuthViewModel(), shouldShowLogOutOptions: $shouldShowLogOutOptions)
                ScrollView {
                    ForEach(userViewModel.users, id: \.uid) { user in
                        MessagesListCellView(user: user)
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
        MessagesListView(userViewModel: UserViewModel())
    }
}
