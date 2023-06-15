//
//  MessageViewModelSpec.swift
//  FirechatTests
//
//  Created by Glenn Ludszuweit on 15/06/2023.
//

import XCTest
import Quick
import Nimble

@testable import Firechat
import Firebase

class MessageViewModelSpec: QuickSpec {
    override func spec() {
        describe("MessageViewModel") {
            var viewModel: MessageViewModel!

            beforeEach {
                viewModel = MessageViewModel()
            }

            afterEach {
                viewModel = nil
            }

            context("getMessages") {
                it("should populate the messages array") {
                    // Prepare test data
                    let currentUser = "mockUserID"
                    let user = User(uid: "user1", username: "User 1", email: "user1@example.com", image: "user1.png")

                    // Create mock Firestore document snapshots
                    let mockMessages = [
                        Message(from: currentUser, to: user.uid, message: "Hello", timestamp: Date(), userImage: user.image, userName: user.username, userEmail: user.email, userId: user.uid),
                        Message(from: currentUser, to: user.uid, message: "How are you?", timestamp: Date(), userImage: user.image, userName: user.username, userEmail: user.email, userId: user.uid)
                    ]

                    let mockSnapshots = mockMessages.map { message -> MockDocumentSnapshot in
                        return MockDocumentSnapshot(data: message.toDict())
                    }

                    // Mock Firestore collection and document retrieval
                    FirebaseManager.shared.firestore = MockFirestore(mockDocuments: mockSnapshots)

                    // Create a mock Coordinator and AlertViewModel
                    let coordinator = Coordinator()
                    let alertViewModel = AlertViewModel()

                    // Set the coordinator's user
                    coordinator.user = user

                    // Call the method under test
                    viewModel.getMessages(coordinator: coordinator, alertViewModel: alertViewModel)

                    // Verify the results
                    expect(viewModel.messages.count).toEventually(equal(mockMessages.count))
                    expect(viewModel.messages).toEventually(contain(mockMessages))
                }
            }

            context("getRecentMessages") {
                it("should populate the recentMessages array") {
                    // Prepare test data
                    let currentUser = "mockUserID"

                    // Create mock Firestore document snapshots
                    let mockRecentMessages = [
                        Message(from: "user1", to: currentUser, message: "Hello", timestamp: Date(), userImage: "user1.png", userName: "User 1", userEmail: "user1@example.com", userId: "user1"),
                        Message(from: "user2", to: currentUser, message: "How are you?", timestamp: Date(), userImage: "user2.png", userName: "User 2", userEmail: "user2@example.com", userId: "user2")
                    ]

                    let mockSnapshots = mockRecentMessages.map { message -> MockDocumentSnapshot in
                        return MockDocumentSnapshot(data: message.toDict())
                    }

                    // Mock Firestore collection and document retrieval
                    FirebaseManager.shared.firestore = MockFirestore(mockDocuments: mockSnapshots)

                    // Create a mock Coordinator and AlertViewModel
                    let coordinator = Coordinator()
                    let alertViewModel = AlertViewModel()

                    // Call the method under test
                    viewModel.getRecentMessages(coordinator: coordinator, alertViewModel: alertViewModel)

                    // Verify the results
                    expect(viewModel.recentMessages.count).toEventually(equal(mockRecentMessages.count))
                    expect(viewModel.recentMessages).toEventually(contain(mockRecentMessages))
                }
            }

            context("sendMessage") {
                it("should send a message") {
                    // Prepare test data
                    let currentUser = "mockUserID"
                    let user = User(uid: "user1", username: "User 1", email: "user1@example.com", image: "user1.png")
                    let messageText = "Hello, how are you?"

                    // Create a mock Coordinator and AlertViewModel
                    let coordinator = Coordinator()
                    let alertViewModel = AlertViewModel()

                    // Set the coordinator's user
                    coordinator.user = user

                    // Call the method under test
                    viewModel.sendMessage(text: messageText, coordinator: coordinator, alertViewModel: alertViewModel)

                    // Verify the results
                    // TODO: Add expectations for Firebase Firestore operations
                    // You can check if the message has been sent to the appropriate collections/documents
                }
            }

            context("removeConversation") {
                it("should remove a conversation") {
                    // Prepare test data
                    let currentUser = "mockUserID"
                    let messageID = "mockMessageID"

                    // Create a mock Coordinator and AlertViewModel
                    let coordinator = Coordinator()
                    let alertViewModel = AlertViewModel()

                    // Call the method under test
                    viewModel.removeConversation(id: messageID, coordinator: coordinator, alertViewModel: alertViewModel)

                    // Verify the results
                    // TODO: Add expectations for Firebase Firestore operations
                    // You can check if the appropriate documents have been deleted
                }
            }
        }
    }
}
