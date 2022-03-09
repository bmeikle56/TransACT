//
//  ProfileView.swift
//  VIPapplication
//
//  Created by Braeden Meikle on 3/6/22.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject private var user: User
    let buttonSize: CGFloat = 45;
    @State private var isShowingMapBoxMapView: Bool = false
    @State private var isShowingSurveyListView: Bool = false
    
    var body: some View {
        
        
        // put at the top for easy access
        NavigationLink(destination: SurveyListView(), isActive: $isShowingSurveyListView) { EmptyView() }
        NavigationLink(destination: MapBoxMapView(), isActive: $isShowingMapBoxMapView) { EmptyView() }
        
        
        VStack {
            ZStack(alignment: .top) {
                
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.white)
                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 80)
                    .shadow(radius: 5, x: 0, y: 3)
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: UIScreen.main.bounds.width, height: 80)
                    .ignoresSafeArea()
                
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
            }
            
            RouteList()
                
            HStack {
                Spacer()
                
                Button(action: {
                    isShowingSurveyListView = true
                }, label: {
                    Image("Survey icon white")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                    
                    
                }).frame(maxWidth: .infinity, maxHeight: buttonSize)
                    .padding(8)
                    .background(Color("UiGreen").opacity(0.7))
                    .cornerRadius(20)
                
                Button(action: {
                    isShowingMapBoxMapView = true
                }, label: {
                    Image("Location icon")
                        .resizable()
                        .frame(maxWidth: buttonSize)
                        .aspectRatio(contentMode: .fit)
                    
                }).frame(maxWidth: .infinity, maxHeight: buttonSize)
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(20)
                
                Button(action: {
                    // does nothing because we are already in this view
                }, label: {
                    Image("Profile icon")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                }).frame(maxWidth: .infinity, maxHeight: buttonSize)
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(20)
                
                Spacer()
            }.frame(width: UIScreen.main.bounds.width)
                .padding(2)
        }.navigationBarHidden(true)
            .environmentObject(user)
    }
}

struct Route: View {
    
    let title: String
    let subTitle: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.white)
                .frame(width: 350, height: 70, alignment: .center)
                .shadow(radius: 5, x: 0, y: 3)
            Text("Dummy route")
        }
    }
}

struct RouteList: View {
        
    var body: some View {
        NavigationView {
            List {
                VStack {
                    Route(title: "Signup survey", subTitle: "Link: ")
                        .padding(.bottom, 10)
                    Route(title: "Midterm survey", subTitle: "Link: ")
                        .padding(.bottom, 10)
                }
            }
            .listStyle(GroupedListStyle())
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
