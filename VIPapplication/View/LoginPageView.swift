//
//  LoginPageView.swift
//  VIPapplication
//
//  Created by Braeden Meikle on 2/13/22.
//

import SwiftUI
import Firebase

struct LoginPageView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showAlert = false
    
    // login function for Firebase
    func logIn() {
        Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
            if error != nil {
                // print(error?.localizedDescription ?? "")
                // throw alert saying incorrect username or password here
            } else {
                print("You signed in")
            }
        }
    }
    
    var body: some View {
        VStack {
            Text("LOG IN")
                .padding(.bottom, 100)
                .font(.custom("PTMono-Regular", size: 36))
            
            ZStack {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 200, height: 40)
                TextField(
                       "Username",
                       text: $username
                )
                    .font(.custom("PTMono-Regular", size: 18)).multilineTextAlignment(.center)
            }
            
            ZStack {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 200, height: 40)
                TextField(
                       "Password",
                       text: $password
                ).font(.custom("PTMono-Regular", size: 18)).multilineTextAlignment(.center)
            }
            
            ZStack {
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 200, height: 40)
                NavigationLink(destination: HomePageView()) {
                    Text("LOG IN")
                        .font(.custom("PTMono-Regular", size: 18))
                        .foregroundColor(.white)
                }
                
            }.navigationBarBackButtonHidden(true)
                .padding(.bottom, 10)
            
            NavigationLink(destination: ResetPasswordView()) {
                Text("Forgot password?")
                    .font(.custom("PTMono-Regular", size: 18))
                    .foregroundColor(.black)
            }.navigationBarBackButtonHidden(true)
                .padding(.bottom, 100)
            
            HStack {
                Text("Don't have an account? ")
                    .font(.custom("PTMono-Regular", size: 18))
                    .padding(-8)
                NavigationLink(destination: SignUpView()) {
                    Text("Sign up")
                        .font(.custom("PTMono-Regular", size: 18))
                        .foregroundColor(.black)
                }
            }
        }
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
