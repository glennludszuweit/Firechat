//
//  RegisterView.swift
//  SwiftUI-Screens
//
//  Created by Glenn Ludszuweit on 21/04/2023.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var authViewModel: AuthViewModel
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var repassword: String = ""
    @State private var image: Image?
    @State private var isShowingImagePicker = false
    
    func loadImage() {
        guard let selectedImage = UIImage(named: "selectedImage") else { return }
        image = Image(uiImage: selectedImage)
    }
    
    var body: some View {
        VStack {
            Group {
                Button(action: {
                    self.isShowingImagePicker = true
                }) {
                    HStack {
                        if image != nil {
                            image!
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
                .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
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
                if authViewModel.validateUser(email: email, pass: password) && password == repassword {
                    authViewModel.register(username: username, email: email, password: password, coordinator: coordinator)
                } else {
                    print("Invalid user!")
                }
            }, label: {
                Text(NSLocalizedString("button_submit", comment: "Submit"))
                    .frame(maxWidth: .infinity)
            }).padding(10)
                .buttonStyle(.borderedProminent)
                .tint(.orange)
            
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