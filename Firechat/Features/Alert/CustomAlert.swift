//
//  ErrorAlert.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 07/06/2023.
//

import SwiftUI

struct CustomAlert: View {
    @StateObject var alertViewModel: AlertViewModel
    
    var body: some View {
        VStack {}.alert(alertViewModel.title, isPresented: $alertViewModel.showAlert) {
            Button(NSLocalizedString("button_okay", comment: "Okay"), role: .destructive) {
                alertViewModel.resetValues()
            }
            Button(NSLocalizedString("button_cancel", comment: "Cancel"), role: .cancel) {
                alertViewModel.resetValues()
            }
        } message: {
            Text(alertViewModel.message)
        }
    }
}

struct CustomAlert_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlert(alertViewModel: AlertViewModel())
    }
}
