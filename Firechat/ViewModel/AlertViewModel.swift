//
//  AlertViewModel.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 07/06/2023.
//

import Foundation

class AlertViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var message: String = ""
    @Published var showAlert: Bool = false
    
    func setErrorValues(customError: ErrorHandler, showAlert: Bool) {
        self.title = customError.errorDescription.title
        self.message = customError.errorDescription.message
        self.showAlert = showAlert
    }
    
    func resetValues() {
        self.title = ""
        self.message = ""
        self.showAlert = false
    }
}
