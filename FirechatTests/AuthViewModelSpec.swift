//
//  AuthViewModelSpec.swift
//  FirechatTests
//
//  Created by Glenn Ludszuweit on 15/06/2023.
//

import XCTest
import Quick
import Nimble
@testable import Firechat
import Firebase

class AuthViewModelSpec: QuickSpec {
    override func spec() {
        describe("AuthViewModel") {
            var viewModel: AuthViewModel!

            beforeEach {
                viewModel = AuthViewModel()
            }

            afterEach {
                viewModel = nil
            }

            context("validateUser") {
                it("should return true when email and password are valid") {
                    let email = "test@example.com"
                    let password = "password123"

                    let result = viewModel.validateUser(email: email, pass: password)

                    expect(result).to(beTrue())
                }

                it("should return false when email is invalid") {
                    let email = "invalidemail"
                    let password = "password123"

                    let result = viewModel.validateUser(email: email, pass: password)

                    expect(result).to(beFalse())
                }

                it("should return false when password is less than 8 characters") {
                    let email = "test@example.com"
                    let password = "pass"

                    let result = viewModel.validateUser(email: email, pass: password)

                    expect(result).to(beFalse())
                }
            }

            context("validateEmail") {
                it("should return true when email is valid") {
                    let email = "test@example.com"

                    let result = viewModel.validateEmail(email: email)

                    expect(result).to(beTrue())
                }

                it("should return false when email is invalid") {
                    let email = "invalidemail"

                    let result = viewModel.validateEmail(email: email)

                    expect(result).to(beFalse())
                }
            }

            context("login") {
                it("should log in the user") {
                    let email = "test@example.com"
                    let password = "password123"
                    let coordinator = Coordinator()
                    let alertViewModel = AlertViewModel()

                    // Set up mock Firebase authentication
                    let mockCurrentUser = User(uid: "mockUserID", email: email)
                    FirebaseManager.shared.auth = MockFirebaseAuth(currentUser: mockCurrentUser)

                    // Call the method under test
                    viewModel.login(email: email, password: password, coordinator: coordinator, alertViewModel: alertViewModel)

                    // Verify the results
                    expect(coordinator.isLoggedIn).toEventually(beTrue())
                }

                it("should show an error message if login fails") {
                    let email = "test@example.com"
                    let password = "password123"
                    let coordinator = Coordinator()
                    let alertViewModel = AlertViewModel()

                    // Set up mock Firebase authentication with an error
                    let mockError = NSError(domain: "test", code: 123, userInfo: nil)
                    FirebaseManager.shared.auth = MockFirebaseAuth(currentUser: nil)
                    FirebaseManager.shared.auth.mockError = mockError

                    // Call the method under test
                    viewModel.login(email: email, password: password, coordinator: coordinator, alertViewModel: alertViewModel)

                    // Verify the results
                    expect(alertViewModel.errorMessage).toEventually(equal(mockError.localizedDescription))
                    expect(alertViewModel.showAlert).toEventually(beTrue())
                    expect(coordinator.isLoggedIn).toEventually(beFalse())
                }
            }

            context("logout") {
                it("should log out the user") {
                    let coordinator = Coordinator()
                    let alertViewModel = AlertViewModel()

                    // Set up mock Firebase authentication
                    FirebaseManager.shared.auth = MockFirebaseAuth(currentUser: User(uid: "mockUserID"))

                    // Call the method under test
                    viewModel.logout(coordinator: coordinator, alertViewModel: alertViewModel)

                    // Verify the results
                    expect(coordinator.isLoggedIn).toEventually(beFalse())
                }

                it("should show an error message if logout fails") {
                    let coordinator = Coordinator()
                    let alertViewModel = AlertViewModel()

                    // Set up mock Firebase authentication with an error
                    let mockError = NSError(domain: "test", code: 123, userInfo: nil)
                    FirebaseManager.shared.auth = MockFirebaseAuth(currentUser: User(uid: "mockUserID"))
                    FirebaseManager.shared.auth.mockError = mockError

                    // Call the method under test
                    viewModel.logout(coordinator: coordinator, alertViewModel: alertViewModel)

                    // Verify the results
                    expect(alertViewModel.errorMessage).toEventually(equal(mockError.localizedDescription))
                    expect(alertViewModel.showAlert).toEventually(beTrue())
                    expect(coordinator.isLoggedIn).toEventually(beTrue())
                }
            }

            // Additional tests for other methods can be added here...
        }
    }
}
