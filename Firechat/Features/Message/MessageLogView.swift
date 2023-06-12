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
            ScrollView(showsIndicators: false) {
                ForEach(0...20, id: \.self) { num in
                    MessageView()
                }
                HStack { Spacer() }
            }.padding()
                .background(Color(.lightGray).opacity(0.5))
            
            MessageFieldView(alertViewModel: alertViewModel, messageViewModel: messageViewModel)
        }.background(Color(.white))
            .navigationTitle(coordinator.user?.username ?? "")
    }
}

struct MessageLogView_Previews: PreviewProvider {
    static var previews: some View {
        MessageLogView(messageViewModel: MessageViewModel(), alertViewModel: AlertViewModel())
    }
}
