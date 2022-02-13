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
                .padding(.bottom, 100)
            // image
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.green)
                    .frame(width: 50, height: 30)
                NavigationLink(destination: LoginView()) {
                    Text("Google")
                }
            }
            ZStack {
                NavigationLink(destination: LoginView()) {
                    Text("Email")
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
