//
//  LoginView.swift
//  VIPapplication
//
//  Created by Braeden Meikle on 2/13/22.
//

import SwiftUI


struct SetupView: View {

    @EnvironmentObject var user: User
    
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("LOG IN")
                    .font(.custom("PTMono-Bold", size: 36))
                
                Image("SetupView image").padding(.bottom, 80)
                
                ZStack {
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: 282, height: 50)
                    NavigationLink(destination: LoginPageView()) {
                        Text("Google")
                            .font(.custom("PTMono-Bold", size: 18))
                            .foregroundColor(.white)
                    }
                            
                }.navigationBarBackButtonHidden(true)
                
                ZStack {
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: 282, height: 50)
                    NavigationLink(destination: LoginPageView()) {
                        Text("Email")
                            .font(.custom("PTMono-Bold", size: 18))
                            .foregroundColor(.white)
                    }
                }.padding(.bottom, 30)
                    .navigationBarBackButtonHidden(true)
                
                HStack {
                    Text("Don't have an account? ")
                        .font(.custom("PTMono-Regular", size: 18))
                    
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign up")
                            .font(.custom("PTMono-Bold", size: 18))
                            .foregroundColor(.black)
                    }.padding(-8)
                }
            }.navigationBarHidden(true)
        }.navigationBarHidden(true)
        .environmentObject(user)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SetupView().environmentObject(User())
        }
    }
}
