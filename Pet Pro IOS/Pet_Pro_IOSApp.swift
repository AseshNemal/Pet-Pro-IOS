//
//  Pet_Pro_IOSApp.swift
//  Pet Pro IOS
//
//  Created by Asesh Nemal on 2025-06-19.
//

import SwiftUI
import Firebase

@main
struct Pet_Pro_IOSApp: App {
    // Initialize Firebase when the app launches
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
