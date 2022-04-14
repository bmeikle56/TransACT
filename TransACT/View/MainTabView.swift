//
//  MainTabView.swift
//  TransACT
//
//  Created by Braeden Meikle on 4/5/22.
//  followed the structure found on https://stackoverflow.com/questions/69068246/swiftui-custom-tab-bar-icons-not-changing-the-tab-area-is-above-it

import SwiftUI

struct MainTabView: View {
    
    // pass this value down to the tab bar view
    @State var viewType: String = "SurveyListView"
    
    var body: some View {
        
        VStack {
            Spacer().frame(height: 30)
            TransACTBar()
            
            switch viewType {
            case "SurveyListView":
                SurveyListView()
            case "MapBoxMapView":
                MapBoxMapView()
            default:
                ProfileView()
            }
            
//            SurveyListView()
//            MapBoxMapView()
//            ProfileView()
            TabBarView(viewType: $viewType)
            Spacer().frame(height: 20)
        }.ignoresSafeArea()
    }
}

struct TransACTBar: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.white)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 90)
                .shadow(radius: 5, x: 0, y: 2)
            HStack {
                Image("SetupView image")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .padding(.leading, 30)
                Spacer()
                Text("TranSACT")
                    .padding(.trailing, 30)
                    .font(.system(size: 32, weight: .bold, design: .default))
            }
        }
    }
}

struct TabBarView: View {
    
    // control which view is there based on the buttons and pass that back up
    @Binding var viewType: String
    
    var body: some View {
        HStack(spacing: 50) {
            TabBarButton(name: "Survey icon", isActive: viewType == "SurveyListView" ? true : false)
            TabBarButton(name: "Location icon", isActive: viewType == "MapBoxMapView" ? true : false)
            TabBarButton(name: "Profile icon", isActive: viewType == "ProfileView" ? true : false)
        }
    }
}

struct TabBarButton: View {
    
    let name: String
    @State var isActive: Bool
    
    let buttonSize: CGFloat = 60
    let circleSize: CGFloat = 10
    
    var body: some View {
        
        Button(action: {
            //isActive = true
        }, label: {
            VStack(spacing: 10) {
                Spacer().frame(height: 10)
                Image(name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: buttonSize, height: buttonSize)
                if isActive {
                    // denote that you are on this view
                    Circle()
                    .fill(.green)
                    .frame(width: circleSize, height: circleSize)
                } else {
                    // take up space where circle is
                    Spacer().frame(height: 10)
                }
            }
        })
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView().environmentObject(User())
    }
}
