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

    var body: some View {
        VStack {
            Text("SIGN UP")
                .padding(.bottom, 100)
                .font(.custom("PTMono-Regular", size: 36))
            
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
                SecureField(
                       "Password",
                       text: $password
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
                NavigationLink(destination: LoginPageView()) {
                    Text("SIGN UP")
                        .font(.custom("PTMono-Regular", size: 18))
                        .foregroundColor(.white)
                }
                
            }.navigationBarBackButtonHidden(true)
                .padding(.bottom, 100)
            
            HStack {
                Text("Have an account? ")
                    .font(.custom("PTMono-Regular", size: 18))
                    .padding(-8)
                Button("Log in") {
                    handleSignup(email: email, password: password)
                    self.presentationMode.wrappedValue.dismiss()
                }
                .font(.custom("PTMono-Regular", size: 18))
                .foregroundColor(.black)
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
