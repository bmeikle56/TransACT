//
//  SetupView.swift
//  TransACT
//
//  Created by Braeden Meikle on 2/13/22.
//

import SwiftUI


struct SetupView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                Text("LOG IN").font(.custom("PTMono-Bold", size: 36))
                Image("SetupView image")
                Spacer().frame(height: 80)
                ZStack {
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: 282, height: 50)
                    HStack {
                        Image("Google")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Spacer().frame(width: 60)
                        NavigationLink(destination: LoginPageView()) {
                            Text("Google")
                                .font(.custom("PTMono-Bold", size: 18))
                                .foregroundColor(.white)
                        }
                        Spacer().frame(width: 100)
                    }
                }
                ZStack {
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: 282, height: 50)
                    HStack {
                        Image("Email")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Spacer().frame(width: 70)
                        NavigationLink(destination: LoginPageView()) {
                            Text("Email")
                                .font(.custom("PTMono-Bold", size: 18))
                                .foregroundColor(.white)
                        }
                        Spacer().frame(width: 105)
                    }
                }
                Spacer().frame(height: 30)
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
                Spacer().frame(height: 60)
            }
        }.navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SetupView()
        }
    }
}
