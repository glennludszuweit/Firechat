//
//  FirechatApp.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 05/06/2023.
//

import SwiftUI

@main
struct FirechatApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView( alertViewModel: AlertViewModel())
                .environmentObject(Coordinator())
                .environmentObject(AlertViewModel())
        }
    }
}
