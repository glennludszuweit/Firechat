//
//  MessagesHeaderView.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 07/06/2023.
//

import SwiftUI

struct MessagesHeaderView: View {
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var alertViewModel: AlertViewModel
    @StateObject var userViewModel: UserViewModel
    @StateObject var authViewModel: AuthViewModel
    @Binding var shouldShowLogOutOptions: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: userViewModel.user?.image ?? "")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 50, height: 50)
                        .overlay(RoundedRectangle(cornerRadius: 45)
                            .stroke(.orange, lineWidth: 3)
                        )
                        .onTapGesture {
                            shouldShowLogOutOptions.toggle()
                        }
                } else {
                    ProgressView()
                }
            }
            
            
            VStack(alignment: .leading, spacing: 4) {
                Text(userViewModel.user?.username.uppercased() ?? "")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color("DarkOrange"))
                
                HStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 14, height: 14)
                    Text("online")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.lightGray))
                }
                
            }
            
            Spacer()
            Button {
                print("New message")
            } label: {
                Image(systemName: "plus.message")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.orange)
            }
        }
        .actionSheet(isPresented: $shouldShowLogOutOptions) {
            .init(title: Text(NSLocalizedString("text_settings", comment: "Settings")), buttons: [
                .destructive(Text(NSLocalizedString("text_logout", comment: "Logout")), action: {
                    authViewModel.logout(coordinator: coordinator, alertViewModel: alertViewModel)
                }),
                    .cancel()
            ])
        }
        .padding()
        .background(
            Color.white // any non-transparent background
                .shadow(color: Color("DarkOrange"), radius: 3, x: 0, y: 0)
                .mask(Rectangle().padding(.bottom, -20)) /// here!
        )
    }
}

struct ChatHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesHeaderView(userViewModel: UserViewModel(), authViewModel: AuthViewModel(), shouldShowLogOutOptions: .constant(false))
    }
}
