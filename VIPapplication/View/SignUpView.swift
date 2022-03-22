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
    
    // used for returning back to a previous view
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // sign up function for Firebase
    func handleSignup(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                // failure
            } else {
                // success
            }
        }
    }
    
    
    let upCaseMissing = "1 uppercase letter" // missing uppercase
    let lowCaseMissing = "1 lowercase letter" // missing lowercase
    let numMissing = "1 number" // missing number
    let specialCharMissing = "1 special character" // missing special character
    let lengthMissing = "at least 8 characters" // too short
    let comma = ", "
    let and = " and "
    
    @State private var badPasswordMessage: String = ""
    @State private var passwordIsStrong: Bool = true
    
    /* function for if the password is strong enough
     
    requirements for a sufficiently strong password:
     - >=8 characters long
     - >=1 upper case character
     - >=1 lower case character
     - >=1 number
     - >=1 special character
     
     strongPassword returns a tuple:
     0 -> boolean whether the password was sufficiently strong
     1 -> personalized message of how to fix the password if it is not, "" if it is proper
     */
    func strongPassword(password: String) -> (Bool, String) {
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
        
        /* all requirements in 1 line:
         let requirement: String = ".*[a-z]+[A-Z]+[0-9]+[!@#$%^&*]+.*"
         let result: Bool = NSPredicate(format:"SELF MATCHES %@", requirement).evaluate(with: password)
         return result && password.count >= 8
         */
        
        // updated: split up the requirements so the bad password message can be more helpful:
        let upCaseReq: String = ".*[A-Z]+.*"
        let lowCaseReq: String = ".*[a-z]+.*"
        let numReq: String = ".*[0-9]+.*"
        let specialCharReq: String = ".*[!@#$%^&*]+.*"
        let lengthReq: Bool = password.count >= 8
        
        // the String array is for the bad password message, initialize an empty String array
        var errors: [String] = [String]()
        
        let hasUpCase: Bool = NSPredicate(format:"SELF MATCHES %@", upCaseReq).evaluate(with: password)
        if !hasUpCase {
            errors.append(upCaseMissing)
        }
        
        let hasLowCase: Bool = NSPredicate(format:"SELF MATCHES %@", lowCaseReq).evaluate(with: password)
        if !hasLowCase {
            errors.append(lowCaseMissing)
        }
        
        let hasNum: Bool = NSPredicate(format:"SELF MATCHES %@", numReq).evaluate(with: password)
        if !hasNum {
            errors.append(numMissing)
        }
        
        let hasSpecialChar: Bool = NSPredicate(format:"SELF MATCHES %@", specialCharReq).evaluate(with: password)
        if !hasSpecialChar {
            errors.append(specialCharMissing)
        }
        
        let longEnough: Bool = NSPredicate(format:"SELF MATCHES %@", lengthReq).evaluate(with: password)
        if !longEnough {
            errors.append(lengthMissing)
        }
        
        return (hasUpCase && hasLowCase && hasNum && hasSpecialChar && longEnough, badPasswordMessage(errors: errors))
    }
    
    func badPasswordMessage(errors: [String]) -> String {
        /* default message no matter what
         guaranteed >= 1 */
        var message: String = "Password must contain "
        
        // keep track of the number of errors so the message can be displayed with proper grammar
        let numErrors: Int = errors.count;
        
        /*
         1 error: Password must contain ...
         2 errors: Password must contain ... and ...
         3+ errors: Password must contain ..., ..., and ...
         */
        switch numErrors {
        case 1:
            message += errors[0]
        case 2:
            message += errors[0] + and + errors[1]
        default:
            for i in 0...errors.count - 1 {
                if i == errors.count - 1 {
                    message += errors[i] + "!"
                } else if i == errors.count - 2 {
                    message += errors[i] + "," + and
                } else {
                    message += errors[i] + comma
                }
            }
        }
        
        return message
    }
    
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
                    Text(strongPassword(password: password).1) //badPasswordMessage
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
                        let result = strongPassword(password: password)
                        if !result.0 {
                            passwordIsStrong = false
                            badPasswordMessage = result.1
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
