//
//  LoginPageView.swift
//  TransACT
//
//  Created by Braeden Meikle on 2/13/22.
//

import SwiftUI


struct LoginPageView: View {
    
    @EnvironmentObject var user: User
    @ObservedObject var locationManager = LocationManager.shared
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var successfulLogin: Bool = true
    @State private var showHomePageView: Bool = false
    
    var body: some View {
        
        ZStack {
            NavigationLink(destination: RequestLocationNotifView(), isActive: $showHomePageView, label: { EmptyView() }).environmentObject(user)
            
            VStack {
                Text("LOG IN").font(.custom("PTMono-Bold", size: 36))
                Spacer().frame(height: 80)
                if !successfulLogin {
                    Text("Incorrect email or password!")
                        .font(.custom("PTMono-Regular", size: 18))
                        .foregroundColor(.red)
                }
                
                ZStack {
                    TextField(
                           "Email",
                           text: $email
                    )
                        .autocapitalization(.none)
                        .frame(width: 250, height: 15)
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
                    Button("Log in") {
                        FirebaseManager.handleLogin(email: email, password: password, user: user) { (response) in
                            switch response {
                            case .success(let user):
                                print("User \(user.uid) Logged in.")
                                user.setUserEmail(email: self.email)
                                showHomePageView = true; successfulLogin = true
                            case .failure(let error):
                                print("Error Logining in \(error)")
                                successfulLogin = false; showHomePageView = false
                            }
                        }
                    }
                        .font(.custom("PTMono-Bold", size: 18))
                        .foregroundColor(.white)
                }
                Spacer().frame(height: 20)
                NavigationLink(destination: ResetPasswordView()) {
                    Text("Forgot password?")
                        .font(.custom("PTMono-Regular", size: 18))
                        .foregroundColor(.black)
                }
                Spacer().frame(height: 100)
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
