//
//  SignUpView.swift
//  VIPapplication
//
//  Created by Braeden Meikle on 2/20/22.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @State private var passwordsMatch: Bool = true
    @State private var passwordIsStrong: Bool = false
    
    // used for returning back to a previous view
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // sign up function for Firebase
    func handleSignup(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                // failure
            } else {
                // success
                print("You signed up")
            }
        }
    }
    
    /* function for if the password is strong enough
    requirements:
     - at least 8 characters long
     - >0 upper case character
     - >0 lower case character
     - >0 number
     - >0 special character
     */
    func strongPassword(password: String) -> Bool {
        /* see NSRegularExpression and NSPredicate packages
         helpful links:
         https://stackoverflow.com/questions/35957696/nspredicate-for-regex-pattern-matching-crashes
         https://developer.apple.com/documentation/foundation/nspredicate
         https://stackoverflow.com/questions/29535792/check-if-a-string-contains-at-least-a-uppercase-letter-a-digit-or-a-special-ch
         https://code.tutsplus.com/tutorials/swift-and-regular-expressions-syntax--cms-26387
         
         * = 0 or more
         + = at least 1
         ? = 0 or 1
         [] signifies a set
         - indicates a range
         . matches any character except line breaks
        */
        
        let requirement: String = ".*[a-z]+[A-Z]+[0-9]+[!@#$%^&*]+.*"
        let result: Bool = NSPredicate(format:"SELF MATCHES %@", requirement).evaluate(with: password)
        
        return result && password.count >= 8
    }
    
    //func badPasswordMessage(
    
    var body: some View {
        VStack {
            Text("SIGN UP")
                .padding(.bottom, 40)
                .font(.custom("PTMono-Bold", size: 36))
                        
            VStack {
                if !passwordsMatch {
                    Text("Passwords do not match!")
                        .font(.custom("PTMono-Regular", size: 18))
                        .foregroundColor(.red)
                }
                
                if !passwordIsStrong {
                    Text("Password must contain 1 uppercase and lowercase character and 1 number!")
                        .font(.custom("PTMono-Regular", size: 18))
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
                
                TextField(
                       "Email",
                       text: $email
                )
                    .autocapitalization(.none)
                    .frame(width: 250, height: 15, alignment: .center)
                    .padding()
                    .background(Color(.systemGray6))
                    .font(.custom("PTMono-Regular", size: 18)).multilineTextAlignment(.center)
                    
                SecureField(
                       "Password",
                       text: $password
                )
                    .autocapitalization(.none)
                    .frame(width: 250, height: 15, alignment: .center)
                    .padding()
                    .background(Color(.systemGray6))
                    .font(.custom("PTMono-Regular", size: 18)).multilineTextAlignment(.center)
                
                SecureField(
                       "Confirm Password",
                       text: $confirmPassword
                )
                    .autocapitalization(.none)
                    .frame(width: 250, height: 15, alignment: .center)
                    .padding()
                    .background(Color(.systemGray6))
                    .font(.custom("PTMono-Regular", size: 18)).multilineTextAlignment(.center)
                
                ZStack {
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: 282, height: 50)
                    Button("SIGN UP") {
                        if !strongPassword(password: password) {
                            passwordIsStrong = false
                        } else {
                            passwordIsStrong = true
                        }
                        
                        if password != confirmPassword {
                            passwordsMatch = false
                        } else {
                            // passwords matched
                            passwordsMatch = true
                                                
                            handleSignup(email: email, password: password)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }.font(.custom("PTMono-Bold", size: 18))
                        .foregroundColor(.white)
                }.navigationBarBackButtonHidden(true)
                    .padding(.bottom, 100)
                
                HStack {
                    Text("Have an account? ")
                        .font(.custom("PTMono-Regular", size: 18))
                        .padding(-8)
                    Button("Log in") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .font(.custom("PTMono-Bold", size: 18))
                    .foregroundColor(.black)
                }
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
