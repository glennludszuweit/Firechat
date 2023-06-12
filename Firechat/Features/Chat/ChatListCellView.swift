//
//  ChatListCellView.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 07/06/2023.
//

import SwiftUI

struct ChatListCellView: View {
    var user: User?
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                AsyncImage(url: URL(string: user?.image ?? "")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 50, height: 50)
                            .overlay(RoundedRectangle(cornerRadius: 45)
                                .stroke(.orange, lineWidth: 3)
                            )
                    } else {
                        ProgressView()
                    }
                }
                
                
                VStack(alignment: .leading) {
                    Text(user?.username ?? "")
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
        ChatListCellView()
    }
}
