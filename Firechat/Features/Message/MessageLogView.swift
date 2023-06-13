//
//  MessageLogView.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 08/06/2023.
//

import SwiftUI

struct MessageLogView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var messageViewModel: MessageViewModel
    @StateObject var alertViewModel: AlertViewModel
    
    var body: some View {
        VStack {
            HStack { Spacer() }
            ScrollViewReader{ proxy in
                ScrollView(showsIndicators: false) {
                    VStack {
                        ForEach(messageViewModel.messages, id: \.id) { message in
                            MessageView(message: message)
                        }
                        HStack { Spacer() }
                            .id("Bottom")
                    }.onReceive(messageViewModel.$proxyCounter) { _ in
                        withAnimation(.easeOut(duration: 0.5)) {
                            proxy.scrollTo("Bottom", anchor: .bottom)
                        }
                    }
                }.padding()
                    .background(Color(.lightGray).opacity(0.5))
            }
            
            MessageFieldView(alertViewModel: alertViewModel, messageViewModel: messageViewModel)
        }.background(Color(.white))
            .navigationTitle(coordinator.user?.username ?? "")
            .onAppear {
                messageViewModel.getMessages(coordinator: coordinator, alertViewModel: alertViewModel)
            }
    }
}

struct MessageLogView_Previews: PreviewProvider {
    static var previews: some View {
        MessageLogView(messageViewModel: MessageViewModel(), alertViewModel: AlertViewModel())
    }
}
