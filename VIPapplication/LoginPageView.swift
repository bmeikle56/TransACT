//
//  LoginPageView.swift
//  VIPapplication
//
//  Created by Braeden Meikle on 2/13/22.
//

import SwiftUI

struct LoginPageView: View {
    
    @State private var username: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField(
                       "Username",
                       text: $username
                   )
                NavigationLink(destination: MapBoxMapView()) {
                    Text("LOG IN").font(Font.custom(FontName.bold, size: 32))
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
