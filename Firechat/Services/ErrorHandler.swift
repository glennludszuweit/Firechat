//
//  ErrorHandler.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 07/06/2023.
//

import Foundation

struct ErrorMessage {
    let title: String
    let message: String
}

enum ErrorHandler: Error {
    // Authentication errors
    case invalidLogin
    case registerError
    case emailNotRegistered
    case imageNotSaved
    case failedToSaveUserInfo
    case failedToLogout
    // API errors
    case fetchingError
    case noDataFound
}

extension ErrorHandler {
     var errorDescription: ErrorMessage {
        switch self {
        // Authentication errors
        case .invalidLogin:
            return ErrorMessage(title: "Login Error.", message: "Incorrect email or password.")
        case .registerError:
            return ErrorMessage(title: "Registration Error.", message: "Incorrect email or password does not match.")
        case .emailNotRegistered:
            return ErrorMessage(title: "Password reset Error.", message: "Email address not registered.")
        case .imageNotSaved:
            return ErrorMessage(title: "Upload Fail.", message: "Failed to upload user image.")
        case .failedToSaveUserInfo:
            return ErrorMessage(title: "User not Saved.", message: "Failed to save user information.")
        case .failedToLogout:
            return ErrorMessage(title: "Logout Fail.", message: "Failed to logout user.")
        // API errors
        case .fetchingError:
            return ErrorMessage(title: "Fetch Error.", message: "Error fetching API data.")
        case .noDataFound:
            return ErrorMessage(title: "Data Error.", message: "No Data Found.")
        }
    }
}
