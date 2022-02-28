//
//  HomePageView.swift
//  VIPapplication
//
//  Created by Braeden Meikle on 2/20/22.
//

import SwiftUI

struct HomePageView: View {
    
    @EnvironmentObject var user: User
    
    var body: some View {
        VStack {
            Text("YOU ARE LOGGED IN")
                .padding()
                .multilineTextAlignment(.center)
                .lineSpacing(10)
                .font(.custom("PTMono-Regular", size: 28))
            
            Image("HomePageView image").padding(.bottom, 100)
            
            ZStack {
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 282, height: 50)
                NavigationLink(destination: RequestLocationNotifView()) {
                    Text("Get started").font(.custom("PTMono-Regular", size: 18))
                        .foregroundColor(.white)
                }
                
            }.navigationBarBackButtonHidden(true)
                .padding(.bottom, 10)
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView().environmentObject(User())
    }
}
