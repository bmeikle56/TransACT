//
//  LoginPageView.swift
//  VIPapplication
//
//  Created by Braeden Meikle on 2/13/22.
//

import SwiftUI

struct LoginPageView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        //NavigationView {
            VStack {
                Text("LOG IN")
                    .padding(.bottom, 100)
                    .font(Font.custom("PTMono-Bold", size: 28))
                ZStack {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 200, height: 40)
                    TextField(
                           "Username",
                           text: $username
                    )
                        .multilineTextAlignment(.center)
                }
                ZStack {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 200, height: 40)
                    TextField(
                           "Password",
                           text: $password
                    )
                        .multilineTextAlignment(.center)
                }
                ZStack {
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: 200, height: 40)
                    NavigationLink(destination: MapBoxMapView()) {
                        Text("LOG IN")
                            .font(Font.custom("PTMono-Bold", size: 18))
                    }
                    /*Button(action: { login() }) {
                        Text("Sign in")
                    }*/
                }.padding(.bottom, 10)
                NavigationLink(destination: MapBoxMapView()) {
                    Text("Forgot password?")
                        .font(Font.custom("PTMono-Bold", size: 18))
                }.padding(.bottom, 100)
                HStack {
                    Text("Don't have an account? ").font(Font.custom("PTMono-Bold", size: 18))
                    NavigationLink(destination: MapBoxMapView()) {
                        Text("Sign up")
                            .font(Font.custom("PTMono-Bold", size: 18))
                    }
                }
            //}
        }
    }
}

/*func login() {
    Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
        if error != nil {
            print(error?.localizedDescription ?? "")
        } else {
            print("success")
        }
    }
}*/

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
