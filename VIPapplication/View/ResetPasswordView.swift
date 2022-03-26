//
//  ResetPasswordView.swift
//  VIPapplication
//
//  Created by Braeden Meikle on 2/20/22.
//

import SwiftUI
import FirebaseAuth
import AuthenticationServices

struct ResetPasswordView: View {
    
    @State private var email: String = ""
    @State private var showAlert: Bool = false
    @State private var emailIsValid: Bool = true
    @State private var errString: String = ""
    
    // used for returning back to a previous view
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    func resetPassword(email:String, resetCompletion:@escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            if let error = error {
                resetCompletion(.failure(error))
            } else {
                resetCompletion(.success(true))
            }
        }
    )}
    
    var body: some View {
        VStack {
            Text("RESET PASSWORD")
                .padding(.bottom, 100)
                .font(.custom("PTMono-Bold", size: 36))
            
            if !emailIsValid {
                Text("Please enter a valid email address!")
                    .font(.custom("PTMono-Regular", size: 14))
                    .foregroundColor(.red)
            }
            
            if errString != "" {
                Text("No user with this email address has been found")
                    .font(.custom("PTMono-Regular", size: 14))
                    .foregroundColor(.red)
                    .lineLimit(nil)
                    .frame(width: 282)
            }
            
            ZStack {
                TextField(
                       "Email",
                       text: $email
                )
                    .autocapitalization(.none)
                    .frame(width: 250, height: 15, alignment: .center)
                    .padding()
                    .background(Color(.systemGray6))
                    .font(.custom("PTMono-Regular", size: 18)).multilineTextAlignment(.center)
            }
            
            ZStack {
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 282, height: 50)
                
                Button("GET RESET EMAIL") {
                    // clean previous errString
                    errString = ""
                    if SignUpView.isValidEmailAddress(email: email) {
                        // valid address, proceed to verification in firebase
                        emailIsValid = true
                        // reset password in firebase
                        resetPassword(email: email) { (result) in
                            switch result {
                            case .failure(let error):
                                self.errString = error.localizedDescription
                            case .success( _):
                                showAlert = true
                                break
                            }
                        }
                    } else {
                        emailIsValid = false
                    }
                    
                }.alert(isPresented: $showAlert) {
                    // alert user an email was sent and send them back to the login page to try again
                    Alert (title: Text("Email was sent!"),
                           message: Text("Check your email for instructions on how to reset your password"),
                           dismissButton: .default(
                            Text("Return to login"),
                            action: {
                                self.presentationMode.wrappedValue.dismiss()
                        
                    }))
                }.font(.custom("PTMono-Bold", size: 18))
                    .foregroundColor(.white)
                
            }.navigationBarBackButtonHidden(true)
                .padding(.bottom, 10)
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
