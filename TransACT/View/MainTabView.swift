//
//  MainTabView.swift
//  TransACT
//
//  Created by Braeden Meikle on 4/5/22.
//  followed the structure found on https://stackoverflow.com/questions/69068246/swiftui-custom-tab-bar-icons-not-changing-the-tab-area-is-above-it

import SwiftUI

// ObservableObject class because the object passed must be of type ObservableObject
class ViewType: ObservableObject {
    var type: String = "SurveyListView"
}

struct MainTabView: View {
    
    // create the object using a StateObject tag that will be passed through views
    @StateObject var viewType: ViewType = ViewType()
    
    var body: some View {
        
        VStack {
            Spacer().frame(height: 40)
            TransACTBar()
            
            switch viewType.type {
            case "SurveyListView":
                SurveyListView()
            case "MapBoxMapView":
                MapBoxMapView()
            default:
                ProfileView()
            }
            
            // pass the environment object down
            TabBarView().environmentObject(viewType)
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

    @EnvironmentObject var viewType: ViewType
    
    var body: some View {
        HStack(spacing: 50) {
            // pass down environment object again
            TabBarButton(imageName: "Survey icon", viewName: "SurveyListView", isActive: viewType.type == "SurveyListView" ? true : false)
                .environmentObject(viewType)
            TabBarButton(imageName: "Location icon", viewName: "MapBoxMapView", isActive: viewType.type == "MapBoxMapView" ? true : false)
                .environmentObject(viewType)
            TabBarButton(imageName: "Profile icon", viewName: "ProfileView", isActive: viewType.type == "ProfileView" ? true : false)
                .environmentObject(viewType)
        }
    }
}

struct TabBarButton: View {
    
    let imageName: String
    let viewName: String
    @State var isActive: Bool
    
    let buttonSize: CGFloat = 60
    let circleSize: CGFloat = 10
    
    @EnvironmentObject var viewType: ViewType
    
    var body: some View {
        
        Button(action: {
            viewType.type = viewName
        }, label: {
            VStack(spacing: 10) {
                Spacer().frame(height: 10)
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
