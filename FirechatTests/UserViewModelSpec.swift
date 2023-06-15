//
//  UserViewModelSpec.swift
//  FirechatTests
//
//  Created by Glenn Ludszuweit on 15/06/2023.
//

import XCTest
import Quick
import Nimble
@testable import Firechat
import Firebase

class UserViewModelSpec: QuickSpec {
    override func spec() {
        describe("UserViewModel") {
            var viewModel: UserViewModel!

            beforeEach {
                viewModel = UserViewModel()
            }

            afterEach {
                viewModel = nil
            }

            context("getCurrentUser") {
                it("should set the authUser property") {
                    // Prepare test data
                    let mockUID = "mockUserID"
                    let mockUsername = "JohnDoe"
                    let mockEmail = "johndoe@example.com"
                    let mockImage = "profile_image.png"

                    // Create a mock Firestore document snapshot
                    let mockSnapshot = MockDocumentSnapshot(data: [
                        "uid": mockUID,
                        "username": mockUsername,
                        "email": mockEmail,
                        "image": mockImage
                    ])

                    // Mock Firestore collection and document retrieval
                    FirebaseManager.shared.firestore = MockFirestore(mockDocuments: [mockSnapshot])

                    // Create an AlertViewModel for error handling
                    let alertViewModel = AlertViewModel()

                    // Call the method under test
                    viewModel.getCurrentUser(alertViewModel: alertViewModel)

                    // Verify the results
                    expect(viewModel.authUser?.uid).toEventually(equal(mockUID))
                    expect(viewModel.authUser?.username).toEventually(equal(mockUsername))
                    expect(viewModel.authUser?.email).toEventually(equal(mockEmail))
                    expect(viewModel.authUser?.image).toEventually(equal(mockImage))
                }
            }

            context("getAllUsers") {
                it("should populate the users array") {
                    // Prepare test data
                    let mockUsers = [
                        User(uid: "user1", username: "User 1", email: "user1@example.com", image: "user1.png"),
                        User(uid: "user2", username: "User 2", email: "user2@example.com", image: "user2.png"),
                        User(uid: "user3", username: "User 3", email: "user3@example.com", image: "user3.png")
                    ]

                    // Create mock Firestore document snapshots
                    let mockSnapshots = mockUsers.map { user -> MockDocumentSnapshot in
                        return MockDocumentSnapshot(data: [
                            "uid": user.uid,
                            "username": user.username,
                            "email": user.email,
                            "image": user.image
                        ])
                    }

                    // Mock Firestore collection and document retrieval
                    FirebaseManager.shared.firestore = MockFirestore(mockDocuments: mockSnapshots)

                    // Create an AlertViewModel for error handling
                    let alertViewModel = AlertViewModel()

                    // Call the method under test
                    viewModel.getAllUsers(alertViewModel: alertViewModel)

                    // Verify the results
                    expect(viewModel.users.count).toEventually(equal(mockUsers.count))
                    expect(viewModel.users).toEventually(contain(mockUsers))
                }
            }

            context("deleteAccount") {
                it("should delete the user's account") {
                    // Prepare test data
                    let mockAuthUser = User(uid: "mockUserID", username: "JohnDoe", email: "johndoe@example.com", image: "profile_image.png")

                    // Mock Firebase Auth and Storage
                    FirebaseManager.shared.auth = MockFirebaseAuth(currentUser: mockAuthUser)
                    FirebaseManager.shared.storage = MockFirebaseStorage()

                    // Create a mock Coordinator and AlertViewModel
                    let coordinator = Coordinator()
                    let alertViewModel = AlertViewModel()

                    // Call the method under test
                    viewModel.deleteAccount(coordinator: coordinator, alertViewModel: alertViewModel)

                    // Verify the results
                    expect(coordinator.isLoggedIn).to(beFalse())
                    // TODO: Add expectations for Firebase Auth and Storage operations
                }
            }
        }
    }
}
