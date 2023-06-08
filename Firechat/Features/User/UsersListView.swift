//
//  UsersListView.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 08/06/2023.
//

import SwiftUI

struct UsersListView: View {
    @StateObject var userViewModel: UserViewModel
    @Binding var showUsers: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "xmark").font(.system(size: 20))
                    .padding(20)
                    .onTapGesture {
                        showUsers = false
                    }
            }
            ScrollView {
                ForEach(userViewModel.users, id: \.uid) { user in
                    UsersListCellView(user: user).onTapGesture {
                        showUsers = false
                    }
                }
            }
        }
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView(userViewModel: UserViewModel(), showUsers: .constant(true))
    }
}
