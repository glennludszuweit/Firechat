//
//  ResetPassView.swift
//  SwiftUI-Screens
//
//  Created by Glenn Ludszuweit on 21/04/2023.
//

import SwiftUI

struct ResetPassView: View {
    @State var email: String = ""
    var body: some View {
        VStack {
            TextField(NSLocalizedString("placeholder_email", comment: "Email"), text: $email)
                .padding(10)
                .textFieldStyle(.roundedBorder)
            
            Text(NSLocalizedString("text_registered_email", comment: "Email"))
                .frame(maxWidth: .infinity)
                .foregroundColor(.gray)
            
            Button(action: {
                print(NSLocalizedString("button_submit", comment: "Submit"))
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

struct ResetPassView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPassView()
    }
}
