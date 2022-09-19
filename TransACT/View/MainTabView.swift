//
//  MainTabView.swift
//  TransACT
//
//  Created by Braeden Meikle on 4/5/22.
//

import SwiftUI

struct MainTabView: View {
    
    // pass through the views
    @State var viewType: String = "SurveyListView"
    
    var body: some View {
        VStack {
            Spacer().frame(height: 20)
            TransACTBar().padding([.bottom], -4)
            Spacer().frame(height: 10)
            switch viewType {
            case "SurveyListView":
                SurveyListView()
                    .navigationBarHidden(true)
            case "MapView":
                MapView()
                    .navigationBarHidden(true)
            default:
                ProfileView()
                    .navigationBarHidden(true)
            }
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
            Rectangle()
                .fill(Color.white)
                .frame(width: UIScreen.main.bounds.width, height: 80)
                .ignoresSafeArea()
            HStack {
                Image("SetupView image")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(.leading, 30)
                Spacer()
                Text("TranSACT")
                    .padding(.trailing, 30)
                    .font(.system(size: 24, weight: .bold, design: .default))
            }
        }
    }
}

struct TabBarView: View {
    @Binding var viewType: String
    
    var body: some View {
        HStack(spacing: UIScreen.main.bounds.size.width / 4.5) {
            if viewType == "SurveyListView" {
                TabBarButton(imageName: "Survey icon", viewName: "SurveyListView", isActive: true, viewType: $viewType)
            } else {
                TabBarButton(imageName: "Survey icon", viewName: "SurveyListView", isActive: false, viewType: $viewType)
            }
            if viewType == "MapView" {
                TabBarButton(imageName: "Location icon", viewName: "MapView", isActive: true, viewType: $viewType)
            } else {
                TabBarButton(imageName: "Location icon", viewName: "MapView", isActive: false, viewType: $viewType)
            }

            if viewType == "ProfileView" {
                TabBarButton(imageName: "Profile icon", viewName: "ProfileView", isActive: true, viewType: $viewType)
            } else {
                TabBarButton(imageName: "Profile icon", viewName: "ProfileView", isActive: false, viewType: $viewType)
            }
        }
    }
}

struct TabBarButton: View {
    
    let imageName: String
    let viewName: String
    @State var isActive: Bool
    
    let buttonSize: CGFloat = 25
    let circleSize: CGFloat = 6
    
    @Binding var viewType: String
    
    var body: some View {
        Button(action: {
            viewType = viewName
        }, label: {
            VStack(spacing: 6) {
                Spacer().frame(height: circleSize)
                Image(imageName)
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
                    Spacer().frame(height: circleSize)
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
