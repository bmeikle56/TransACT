//
//  MainTabView.swift
//  TransACT
//
//  Created by Braeden Meikle on 4/5/22.
//  followed the structure found on https://stackoverflow.com/questions/69068246/swiftui-custom-tab-bar-icons-not-changing-the-tab-area-is-above-it

import SwiftUI

struct MainTabView: View {
    var body: some View {
        
        VStack {
            Spacer().frame(height: 30)
            TransACTBar()
            ProfileView()
            /*TabView {
                SurveyListView()
                MapBoxMapView()
                ProfileView()
            }*/
            TabBarView()
            Spacer()
                .frame(height: 20)
        }
            .ignoresSafeArea()
    }
}

struct TransACTBar: View {
    var body: some View {
        HStack() {
            Image("SetupView image")
                .resizable()
                .frame(width: 70, height: 70)
                .padding(.leading, 30)
            Spacer()
            Text("TranSACT")
                .padding(.trailing, 30)
                .font(.system(size: 32, weight: .bold, design: .default))
        }.frame(width: UIScreen.main.bounds.width)
            .padding([.bottom], 20)
    }
}

struct TabBarView: View {
    var body: some View {
        HStack(spacing: 50) {
            TabBarButton(name: "Survey icon", isActive: true)
            TabBarButton(name: "Location icon", isActive: false)
            TabBarButton(name: "Profile icon", isActive: false)
        }
    }
}

struct TabBarButton: View {
    
    // must provide this in the parameters
    let name: String
    @State var isActive: Bool
    
    let buttonSize: CGFloat = 60
    let circleSize: CGFloat = 10
    
    var body: some View {
        
        Button(action: {
            isActive = true
        }, label: {
            VStack(spacing: 10) {
                Spacer()
                    .frame(height: 10)
                Image(name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: buttonSize, height: buttonSize)
                if isActive {
                    Circle()
                    .fill(.green)
                    .frame(width: circleSize, height: circleSize)
                } else {
                    Spacer()
                        .frame(height: 10)
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
