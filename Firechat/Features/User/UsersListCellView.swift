//
//  UsersListCellView.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 08/06/2023.
//

import SwiftUI

struct UsersListCellView: View {
    var user: User?
    
    var body: some View {
        if user != nil {
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
                    
                    Text(user?.email ?? "")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color("DarkOrange"))
                    
                    Spacer()
                }
                Divider()
                    .padding(.vertical, 8)
            }.padding(.horizontal)
                .padding(.top, 10)
        } else {
            ProgressView()
        }
    }
}

struct UserCellView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListCellView()
    }
}
