//
//  LoginView.swift
//  VIPapplication
//
//  Created by Braeden Meikle on 2/13/22.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            Text("LOG IN")
                .padding(.bottom, 250)
                .font(Font.custom("PTMono-Bold", size: 32))
            // image
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.green)
                    .frame(width: 200, height: 50)
                NavigationLink(destination: LoginPageView()) {
                    Text("Google")
                        .font(Font.custom("PTMono-Bold", size: 24))
                }
            }
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.green)
                    .frame(width: 200, height: 50)
                NavigationLink(destination: LoginPageView()) {
                    Text("Email")
                        .font(Font.custom("PTMono-Bold", size: 24))
                }
            }.padding(.bottom, 100)
            HStack {
                Text("Don't have an account? ").font(Font.custom("PTMono-Bold", size: 18))
                NavigationLink(destination: MapBoxMapView()) {
                    Text("Sign up")
                        .font(Font.custom("PTMono-Bold", size: 18))
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
