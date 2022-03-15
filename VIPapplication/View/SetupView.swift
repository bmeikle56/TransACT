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
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.green)
                        .frame(width: 200, height: 50)
                    NavigationLink(destination: LoginPageView()) {
                        Text("Google").font(.custom("PTMono-Regular", size: 18))
                            .foregroundColor(.black)
                    }
                            
                }.navigationBarBackButtonHidden(true)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.green)
                        .frame(width: 200, height: 50)
                    NavigationLink(destination: LoginPageView()) {
                        Text("Email")
                            .font(.custom("PTMono-Regular", size: 18))
                            .foregroundColor(.black)
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
            }
        }
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
