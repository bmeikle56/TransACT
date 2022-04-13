//
//  MainTabView.swift
//  TransACT
//
//  Created by Braeden Meikle on 4/5/22.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var currentTab: String = ""
    let buttonSize: CGFloat = 45;
    
    var body: some View {
        
        // in order to resize the images they must be imported in smaller size
        
        TabView {
            SurveyListView()
                .onTapGesture{
                    currentTab = "SurveyListView"
                }
                .tabItem {
                    Image("Survey icon")
                }
                .tag("SurveyListView")
            MapBoxMapView()
                .onTapGesture{
                    currentTab = "MapBoxMapView"
                }
                .tabItem {
                    Image("Location icon")
                }
                .tag("MapBoxMapView")
            ProfileView()
                .onTapGesture{
                    currentTab = "ProfileView"
                }
                .tabItem {
                    Image("Profile icon")
                }
                .tag("ProfileView")
        }.padding([.bottom], 10)
        
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView().environmentObject(User())
    }
}
