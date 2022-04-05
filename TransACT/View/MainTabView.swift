//
//  MainTabView.swift
//  TransACT
//
//  Created by Braeden Meikle on 4/5/22.
//

import SwiftUI

struct MainTabView: View {
    
    let buttonSize: CGFloat = 45;
    
    var body: some View {
        TabView {
            SurveyListView()
                .tabItem {
                    Image("Survey icon")
                        .resizable()
                        .frame(maxWidth: buttonSize)
                        .aspectRatio(contentMode: .fit)
                }
            MapBoxMapView()
                .tabItem {
                    Image("Location icon")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                }
            ProfileView()
                .tabItem {
                    Image("Profile icon white")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView().environmentObject(User())
    }
}
