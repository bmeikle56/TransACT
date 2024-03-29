//
//  FirebaseManager.swift
//  TransACT
//
//  Created by Braeden Meikle on 3/26/22.
//

import Foundation
import Firebase

/* All of the Firebase login/signup/reset password functions are contained in this class, allowing imports
 and duplicated code to be saved */
class FirebaseManager {
    
    // login function for Firebase
    static func handleLogin(email: String, password: String, user: User, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                completion(.failure(error!))
            } else {
                user.uid = Auth.auth().currentUser?.uid ?? ""
                completion(.success(user))
            }
        }
    }
    
    // sign up function for Firebase
    static func handleSignup(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                // failure
                print("Failed sign up")
            } else {
                // success
                print("Successful sign up")
            }
        }
    }
    
    // reset password function for Firebase
    static func handleResetPassword(email:String, resetCompletion:@escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            if let error = error {
                resetCompletion(.failure(error))
            } else {
                resetCompletion(.success(true))
            }
        }
    )}
    
    // login function for Firebase
    static func handleLogout() -> Bool {
        do {
            try Auth.auth().signOut()
        } catch let err {
            print(err)
            return false
        }
        return true
    }
    
    // Getter method for Firestore
    static func getFirestore() -> Firestore {
        return Firestore.firestore()
    }
}
