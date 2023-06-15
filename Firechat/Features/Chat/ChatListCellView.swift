//
//  ChatListCellView.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 07/06/2023.
//

import SwiftUI

struct ChatListCellView: View {
    var message: Message?
    
    func sliceString(str: String) -> String {
        if str.count > 25 {
            let startIndex = str.index(str.startIndex, offsetBy: 0)
            let endIndex = str.index(str.startIndex, offsetBy: 20)
            return "\(String(str[startIndex..<endIndex]))..."
        } else {
            return str
        }
    }
    
    func formatToTimeAgo(date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: date, relativeTo: Date())
    }
    
    var body: some View {
        VStack {
            if let message = message {
                HStack(spacing: 16) {
                    AsyncImage(url: URL(string: message.userImage)) { phase in
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
                    
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(message.userName)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color("DarkOrange"))
                        Text(sliceString(str: message.message))
                            .font(.system(size: 14))
                            .foregroundColor(Color(.lightGray))
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                    
                    Text(formatToTimeAgo(date: message.timestamp))
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color("DarkOrange"))
                }
                Divider().offset(y: 10)
//                    .padding(.vertical, 8)
            } else {
                ProgressView()
            }
        }
//        .padding(.horizontal)
//            .padding(.top, 10)
    }
}

struct MessageCellView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListCellView()
    }
}
