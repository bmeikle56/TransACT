//
//  VIPapplicationApp.swift
//  VIPapplication
//
//  Created by Braeden Meikle on 2/13/22.
//

import SwiftUI
import Firebase

class User: ObservableObject, Identifiable {
  @Published var uid = "AI6E6ku3LYLVtEKB7q0E"
}

@main
struct VIPapplicationApp: App {
    init() {
        FirebaseApp.configure()
    }
    var user = User()
    var body: some Scene {
        WindowGroup {
            SetupView().environmentObject(user)
        }
    }
}
