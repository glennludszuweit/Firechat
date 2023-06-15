//
//  FirebaseMock.swift
//  FirechatTests
//
//  Created by Glenn Ludszuweit on 15/06/2023.
//

import Foundation
@testable import Firechat
import Firebase

class MockDocumentSnapshot: DocumentSnapshot {
    private let mockData: [String: Any]

    init(data: [String: Any]) {
        self.mockData = data
    }

    override var data: [String: Any]? {
        return mockData
    }
}

class MockFirestore: Firestore {
    private let mockDocuments: [DocumentSnapshot]

    init(mockDocuments: [DocumentSnapshot]) {
        self.mockDocuments = mockDocuments
    }

    override func collection(_ collectionPath: String) -> CollectionReference {
        return MockCollectionReference(mockDocuments: mockDocuments)
    }
}

class MockCollectionReference: CollectionReference {
    private let mockDocuments: [DocumentSnapshot]

    init(mockDocuments: [DocumentSnapshot]) {
        self.mockDocuments = mockDocuments
    }

    override func getDocuments(completion: @escaping FIRQuerySnapshotBlock) {
        let mockSnapshot = MockQuerySnapshot(documents: mockDocuments)
        completion(mockSnapshot, nil)
    }
}

class MockQuerySnapshot: QuerySnapshot {
    private let mockDocuments: [DocumentSnapshot]

    init(documents: [DocumentSnapshot]) {
        self.mockDocuments = documents
    }

    override var documents: [DocumentSnapshot] {
        return mockDocuments
    }
}

class MockFirebaseAuth: FirebaseAuth {
    private let mockCurrentUser: User?

    init(currentUser: User?) {
        self.mockCurrentUser = currentUser
    }

    override var currentUser: User? {
        return mockCurrentUser
    }

    override func delete(completion: @escaping FIRAuthResultCallback) {
        // Mock deletion operation
        completion(nil, nil)
    }
}

class MockFirebaseStorage: Storage {
    override func reference() -> StorageReference {
        return MockStorageReference()
    }
}

class MockStorageReference: StorageReference {
    override func child(_ pathString: String) -> StorageReference {
        return self
    }

    override func delete(completion: @escaping (Error?) -> Void) {
        // Mock deletion operation
        completion(nil)
    }
}
