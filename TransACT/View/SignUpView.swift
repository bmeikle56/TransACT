//
//  SignUpView.swift
//  TransACT
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
    @State private var emailAddressIsValid: Bool = true
    
    // used for returning back to a previous view
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var badPasswordMessage: String = ""
    @State private var passwordIsStrong: Bool = true
    
    /* returns
     (email validity, passwords match, password strength)
     */
    func errorHierarchy(emailAddressIsValid: Bool, passwordsMatch: Bool, passwordIsStrong: Bool) -> (Bool, Bool, Bool) {
        /* hierarchy:
         - invalid email address takes absolute precedence
         - passwords not match takes precendence over password strength
         - email validity > passwords match > password strength
         */
        if !emailAddressIsValid {return (true, false, false)}
        else if !passwordsMatch {return (false, true, false)}
        else if !passwordIsStrong {return (false, false, true)} // password was weak
        else {return (false, false, false)} // no errors
    }
    
    var body: some View {
        VStack {
            Text("SIGN UP")
                .padding(.bottom, 40)
                .font(.custom("PTMono-Bold", size: 36))
                        
            VStack {
                if errorHierarchy(emailAddressIsValid: emailAddressIsValid, passwordsMatch: passwordsMatch, passwordIsStrong: passwordIsStrong).0 { // invalid email address
                    Text("Please enter a valid email address!")
                        .font(.custom("PTMono-Regular", size: 14))
                        .foregroundColor(.red)
                }
                
                if errorHierarchy(emailAddressIsValid: emailAddressIsValid, passwordsMatch: passwordsMatch, passwordIsStrong: passwordIsStrong).1 { // confirm password != password
                    Text("Passwords do not match!")
                        .font(.custom("PTMono-Regular", size: 14))
                        .foregroundColor(.red)
                }
                
                if errorHierarchy(emailAddressIsValid: emailAddressIsValid, passwordsMatch: passwordsMatch, passwordIsStrong: passwordIsStrong).2 { // weak password
                    Text(LoginManager.isStrongPassword(password: password).1)
                        .font(.custom("PTMono-Regular", size: 14))
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
//                    Button("Sign up") {
//                        email = ""
//                        password = ""
//                        confirmPassword = ""
//
//                        let result = LoginManager.isStrongPassword(password: password)
//                        if !result.0 {
//                            passwordIsStrong = false
//                            badPasswordMessage = result.1
//                        } else {
//                            passwordIsStrong = true
//                        }
//
//                        if password != confirmPassword {
//                            passwordsMatch = false
//                        } else {
//                            passwordsMatch = true
//                        }
//
//                        if !LoginManager.isValidEmailAddress(email: email) {
//                            emailAddressIsValid = false
//                        } else {
//                            emailAddressIsValid = true
//                        }
//
//                        if emailAddressIsValid && passwordsMatch && passwordIsStrong {
//                            FirebaseManager.handleSignup(email: email, password: password)
//                            self.presentationMode.wrappedValue.dismiss()
//                        }
//
//                    }.font(.custom("PTMono-Bold", size: 18))
//                        .foregroundColor(.white)
                    
                    NavigationLink(destination: ConsentPageView()){
                        Button("Sign up") {
                            email = ""
                            password = ""
                            confirmPassword = ""
                            
                            // Verify email validity and password strength
                            let result = LoginManager.isStrongPassword(password: password)
                            if !result.0 {
                                passwordIsStrong = false
                                badPasswordMessage = result.1
                            } else {
                                passwordIsStrong = true
                            }
                            
                            if password != confirmPassword {
                                passwordsMatch = false
                            } else {
                                passwordsMatch = true
                            }
                            
                            if !LoginManager.isValidEmailAddress(email: email) {
                                emailAddressIsValid = false
                            } else {
                                emailAddressIsValid = true
                            }
                            
                            if emailAddressIsValid && passwordsMatch && passwordIsStrong {
                                FirebaseManager.handleSignup(email: email, password: password)
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            
                            // Signup user through firebase
                            
                            FirebaseManager.handleSignup(email: email, password: password)
                            
                        }.font(.custom("PTMono-Bold", size: 18))
                            .foregroundColor(.white)
                    
                    }
                }
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
        }.navigationBarHidden(true)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
