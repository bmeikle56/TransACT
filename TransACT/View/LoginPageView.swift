//
//  LoginPageView.swift
//  VIPapplication
//
//  Created by Braeden Meikle on 2/13/22.
//

import SwiftUI


struct LoginPageView: View {
    
    @EnvironmentObject var user: User
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var successfulLogin: Bool = true
    @State private var showHomePageView: Bool = false
    
    
    var body: some View {
        
        NavigationLink(destination: HomePageView(), isActive: $showHomePageView, label: { EmptyView() }).environmentObject(user)
        
        ZStack {
            
            VStack {
                Text("LOG IN")
                    .padding(.bottom, 100)
                    .font(.custom("PTMono-Bold", size: 36))
                
                if !successfulLogin {
                    Text("Incorrect email or password!")
                        .font(.custom("PTMono-Regular", size: 18))
                        .foregroundColor(.red)
                } else {
                    // should display nothing
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
                        email = ""
                        password = ""
                        
                        let result = FirebaseManager.handleLogin(email: email, password: password, user: user)
                        showHomePageView = result
                        successfulLogin = result
                    }
                        .font(.custom("PTMono-Bold", size: 18))
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
                            .font(.custom("PTMono-Bold", size: 18))
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView().environmentObject(User())
    }
}