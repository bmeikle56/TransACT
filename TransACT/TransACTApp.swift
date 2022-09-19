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
    var email = ""
    
    func setUserEmail(email: String) {
        self.email = email
    }
    
    func getUserEmail() -> String {
        return self.email
    }
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
