//
//  MessageView.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 09/06/2023.
//

import SwiftUI

struct MessageView: View {
    var message: Message
    
    var body: some View {
        VStack {
            if message.from == FirebaseManager.shared.auth.currentUser?.uid {
                CurrentUserMessage()
            } else {
                UserMessage()
            }
        }.onAppear {
            print(message)
        }
    }
    
    @ViewBuilder
    func CurrentUserMessage() -> some View {
        HStack {
            HStack {
                Text(message.message)
                    .font(.system(size: 14))
                    .foregroundColor(Color("DarkOrange"))
            }.padding(8)
                .background(.white)
                .roundedCorner(5, corners: [.topLeft, .topRight, .bottomRight])
            Spacer()
        }.padding(.trailing, 20)
    }
    
    @ViewBuilder
    func UserMessage() -> some View {
        HStack {
            Spacer()
            HStack {
                Text(message.message)
                    .font(.system(size: 14))
                    .foregroundColor(.white)
            }.padding(8)
                .background(.orange)
                .roundedCorner(5, corners: [.bottomLeft, .topLeft, .topRight])
        }.padding(.leading, 20)
    }
}


struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: Message(id: "", from: "", to: "", message: "", timestamp: Date.now))
    }
}
