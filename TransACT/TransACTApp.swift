//
//  TransACTApp.swift
//  TransACT
//
//  Created by Braeden Meikle on 2/13/22.
//

import SwiftUI
import Firebase

class User: ObservableObject, Identifiable {
  @Published var uid = "place holder"
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
