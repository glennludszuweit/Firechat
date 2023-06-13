//
//  RegisterView.swift
//  SwiftUI-Screens
//
//  Created by Glenn Ludszuweit on 21/04/2023.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var alertViewModel: AlertViewModel
    @StateObject var authViewModel: AuthViewModel
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var repassword: String = ""
    @State private var image: UIImage?
    @State private var isShowingImagePicker = false
    
    func canRegister() -> Bool {
        if authViewModel.validateUser(email: email, pass: password) &&
            password == repassword &&
            image != nil &&
            username.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        VStack {
            Group {
                Button(action: {
                    self.isShowingImagePicker = true
                }) {
                    HStack {
                        if let image = self.image {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(.orange, lineWidth: 3)
                                )
                        } else {
                            Image(systemName: "person.fill").resizable().frame(width: 30, height: 30).foregroundColor(.orange)
                        }
                        Spacer()
                    }.padding()
                }
                .sheet(isPresented: $isShowingImagePicker, onDismiss: nil) {
                    ImagePicker(image: self.$image)
                }
                TextField(NSLocalizedString("placeholder_username", comment: "Username"), text: $username)
                TextField(NSLocalizedString("placeholder_email", comment: "Email"), text: $email)
                SecureField(NSLocalizedString("placeholder_password", comment: "Password"), text: $password)
                SecureField(NSLocalizedString("placeholder_repassword", comment: "RePassword"), text: $repassword)
            }.padding(10)
                .textFieldStyle(.roundedBorder)
            
            Text(NSLocalizedString("text_terms", comment: "Terms"))
                .frame(maxWidth: .infinity)
                .foregroundColor(.gray)
                .padding(5)
            
            Button(action: {
                if canRegister() {
                    authViewModel.register(image: image!, username: username, email: email, password: password, coordinator: coordinator, alertViewModel: alertViewModel)
                } else {
                    alertViewModel.setErrorValues(errorMessage: "Invalid User!", showAlert: true)
                }
            }, label: {
                Text(NSLocalizedString("button_submit", comment: "Submit"))
                    .frame(maxWidth: .infinity)
            }).padding(10)
                .buttonStyle(.borderedProminent)
                .tint(.orange)
                .disabled(canRegister() ? false : true)
            
            Spacer()
        }
        .padding()
        .padding(.top, 50.0)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(authViewModel: AuthViewModel())
    }
}
