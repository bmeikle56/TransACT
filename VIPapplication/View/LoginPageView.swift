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
    let incorrectLogin: String = "Incorrect username or password!"
    @State private var successfulLogin: Bool = true
    @State private var showHomePageView: Bool = false
    
    // login function for Firebase
    func handleLogin(username: String, password: String) {
        Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
            if error != nil {
                // show text on screen saying incorrect username or password
                successfulLogin = false;
            } else {
                print("You signed in")
                successfulLogin = true// set it back to false because login was successful
                self.showHomePageView = true
            }
        }
    }
    
    var body: some View {
        ZStack {
            // Links to other views
            NavigationLink(destination: HomePageView(), isActive: $showHomePageView, label: { EmptyView() })
            
            VStack {
                Text("LOG IN")
                    .padding(.bottom, 100)
                    .font(.custom("PTMono-Regular", size: 36))
                
                if !successfulLogin {
                    Text(incorrectLogin)
                        .font(.custom("PTMono-Regular", size: 18))
                        .foregroundColor(.red)
                } else {
                    // should display nothing
                }
                
                ZStack {
                    TextField(
                           "Username",
                           text: $username
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
                    Button("LOG IN") {
                        handleLogin(username: username, password: password)
                    }
                        .font(.custom("PTMono-Regular", size: 18))
                        .foregroundColor(.white)
                    
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
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
