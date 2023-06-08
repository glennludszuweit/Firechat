//
//  MessageCellView.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 07/06/2023.
//

import SwiftUI

struct MessageCellView: View {
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Image(systemName: "person.fill")
                    .font(.system(size: 32))
                    .padding(8)
                    .overlay(RoundedRectangle(cornerRadius: 44)
                        .stroke(.orange, lineWidth: 2)
                    )
                
                
                VStack(alignment: .leading) {
                    Text("Username")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color("DarkOrange"))
                    Text("Message sent to user")
                        .font(.system(size: 14))
                        .foregroundColor(Color(.lightGray))
                }
                Spacer()
                
                Text("22d")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color("DarkOrange"))
            }
            Divider()
                .padding(.vertical, 8)
        }.padding(.horizontal)
            .padding(.top, 10)
    }
}

struct MessageCellView_Previews: PreviewProvider {
    static var previews: some View {
        MessageCellView()
    }
}
