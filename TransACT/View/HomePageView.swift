//
//  HomePageView.swift
//  TransACT
//
//  Created by Braeden Meikle on 2/20/22.
//

import SwiftUI

struct HomePageView: View {
    
    @EnvironmentObject var user: User
    
    var body: some View {
        VStack {
            Text("YOU ARE")
                .padding()
                .multilineTextAlignment(.center)
                .lineSpacing(10)
                .font(.custom("PTMono-Bold", size: 36))
            Text("LOGGED IN")
                .multilineTextAlignment(.center)
                .font(.custom("PTMono-Bold", size: 36))
            Image("HomePageView image")
            Spacer().frame(height: 100)
            ZStack {
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 282, height: 50)
                NavigationLink(destination: MainTabView()) {
                    Text("Get started").font(.custom("PTMono-Bold", size: 18))
                        .foregroundColor(.white)
                }.environmentObject(user)
            }.navigationBarBackButtonHidden(true)
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView().environmentObject(User())
    }
}
