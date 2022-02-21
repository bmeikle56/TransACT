//
//  SignUpView.swift
//  VIPapplication
//
//  Created by Braeden Meikle on 2/20/22.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    // used for returning back to a previous view
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Text("SIGN UP")
                .padding(.bottom, 100)
                .font(.custom("PTMono-Regular", size: 36))
            
            ZStack {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 200, height: 40)
                TextField(
                       "Email",
                       text: $email
                ).font(.custom("PTMono-Regular", size: 18)).multilineTextAlignment(.center)
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
                NavigationLink(destination: LoginPageView()) {
                    Text("SIGN UP")
                        .font(.custom("PTMono-Regular", size: 18))
                        .foregroundColor(.white)
                }
                
            }.navigationBarBackButtonHidden(true)
                .padding(.bottom, 100)
            
            HStack {
                Text("Have an account? ").font(.custom("PTMono-Regular", size: 18))
                    .padding(-8)
                Button("Log in") {
                    self.presentationMode.wrappedValue.dismiss()
                    
                }
                .font(.custom("PTMono-Regular", size: 18))
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
