//
//  LogoutView.swift
//  TransACT
//
//  Created by Braeden Meikle on 4/17/22.
//

import SwiftUI

struct LogoutView: View {
        
    var body: some View {
        VStack {
            Text("YOU ARE")
                .padding()
                .multilineTextAlignment(.center)
                .lineSpacing(10)
                .font(.custom("PTMono-Bold", size: 36))
            Text("LOGGED OUT")
                .multilineTextAlignment(.center)
                .font(.custom("PTMono-Bold", size: 36))
            Image("HomePageView image").padding(.bottom, 100)
            
            ZStack {
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 282, height: 50)
                NavigationLink(destination: RequestLocationNotifView()) {
                    Text("Return to login").font(.custom("PTMono-Bold", size: 18))
                        .foregroundColor(.white)
                }
            }.navigationBarBackButtonHidden(true)
                .padding(.bottom, 10)
                
        }
    }
}

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView()
    }
}
