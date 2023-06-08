//
//  LoginView.swift
//  SwiftUI-Screens
//
//  Created by Glenn Ludszuweit on 21/04/2023.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var alertViewModel: AlertViewModel
    @StateObject var authViewModel: AuthViewModel
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            Image("firebase")
                .resizable()
                .frame(width: 150, height: 150)
                .padding(.bottom, 50)
            
            Group {
                TextField(NSLocalizedString("placeholder_username_email", comment: "Username Email"), text: $email)
                SecureField(NSLocalizedString("placeholder_password", comment: "Password"), text: $password)
            }.padding(10)
                .textFieldStyle(.roundedBorder)
            
            HStack {
                Button {
                    coordinator.repasswordScreen()
                } label: {
                    Text(NSLocalizedString("button_forgot_pass", comment: "Forgot Pass"))
                        .foregroundColor(.orange)
                }.padding()
                    .padding(.top, -10)
                    .padding(.bottom, -10)
                Spacer()
            }
            
            Button(action: {
                if authViewModel.validateUser(email: email, pass: password) {
                    authViewModel.login(email: email, password: password, coordinator: coordinator, alertViewModel: alertViewModel)
                } else {
                    print("Invalid user!")
                }
            }, label: {
                Text(NSLocalizedString("button_submit", comment: "Login"))
                    .frame(maxWidth: .infinity)
            }).padding(10)
                .buttonStyle(.borderedProminent)
                .tint(.orange)
                .disabled(authViewModel.validateUser(email: email, pass: password) ? false : true)
            
            
            Spacer()
            
            HStack {
                Text("Don't have an account yet?")
                Button {
                    coordinator.registerScreen()
                } label: {
                    Text(NSLocalizedString("button_register", comment: "Register"))
                        .foregroundColor(.orange)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .padding()
        .padding(.top, 50)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(authViewModel: AuthViewModel())
    }
}
