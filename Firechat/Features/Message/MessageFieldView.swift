//
//  MessageFieldView.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 09/06/2023.
//

import SwiftUI

struct MessageFieldView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var alertViewModel: AlertViewModel
    @StateObject var userViewModel: UserViewModel
    @State var message: String = ""
    var messageViewModel: MessageViewModel
    
    var body: some View {
        HStack{
            Image(systemName: "photo.on.rectangle")
                .font(.system(size: 24))
                .foregroundColor(Color(.darkGray))
            TextField("Description", text: $message)
                .textFieldStyle(.roundedBorder)
            Button {
                if message.count > 0 {
                    messageViewModel.sendMessage(text: message, coordinator: coordinator, alertViewModel: alertViewModel)
                    message = ""
                }
            } label: {
                Text("Send")
                    .foregroundColor(Color(.white))
            }.buttonStyle(.borderedProminent)
        }.padding()
    }
}

struct MessageFieldView_Previews: PreviewProvider {
    static var previews: some View {
        MessageFieldView(alertViewModel: AlertViewModel(), userViewModel: UserViewModel(), messageViewModel: MessageViewModel())
    }
}
