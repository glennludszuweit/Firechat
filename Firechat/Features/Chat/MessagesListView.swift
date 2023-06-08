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
                    ForEach(0...10, id: \.self) { num in
                        MessageCellView()
                    }
                }
            }.onAppear {
                userViewModel.getCurrentUser()
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
