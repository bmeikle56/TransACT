//
//  MainTabView.swift
//  TransACT
//
//  Created by Braeden Meikle on 4/5/22.
//

import SwiftUI

struct MainTabView: View {
    
    let buttonSize: CGFloat = 45;
    @State var isShowingSurveyListView: Bool = false
    @State var isShowingMapBoxMapView: Bool = false
    @State var isShowingProfileView: Bool = false
    
    var body: some View {
        TabView {
            SurveyListView()
                .tabItem {
                    Button(action: {
                        isShowingSurveyListView = true
                        isShowingMapBoxMapView = false
                        isShowingProfileView = false
                    }, label: {
                        Image("Survey icon")
                            .resizable()
                            .frame(width: buttonSize, height: buttonSize)
                    }).frame(maxWidth: .infinity, maxHeight: buttonSize)
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(20)
                }
            MapBoxMapView()
                .tabItem {
                    Button(action: {
                        isShowingSurveyListView = false
                        isShowingMapBoxMapView = true
                        isShowingProfileView = false
                    }, label: {
                        Image("Location icon")
                            .resizable()
                            .frame(width: buttonSize, height: buttonSize)
                    }).frame(maxWidth: .infinity, maxHeight: buttonSize)
                        .padding(8)
                        //.background(Color("UiGreen").opacity(0.7))
                        .background(Color.white)
                        .cornerRadius(20)
                }
            ProfileView()
                .tabItem {
                    Button(action: {
                        isShowingSurveyListView = false
                        isShowingMapBoxMapView = false
                        isShowingProfileView = true
                    }, label: {
                        Image("Profile icon")
                            .resizable()
                            .frame(width: buttonSize, height: buttonSize)
                    }).frame(maxWidth: .infinity, maxHeight: buttonSize)
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(20)
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView().environmentObject(User())
    }
}
