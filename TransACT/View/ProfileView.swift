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
            
            Profile()
                
            HStack {
                Spacer()
                
                Button(action: {
                    isShowingSurveyListView = true
                }, label: {
                    Image("Survey icon")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                    
                    
                }).frame(maxWidth: .infinity, maxHeight: buttonSize)
                    .padding(8)
                    .background(Color.white)
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
                    Image("Profile icon white")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                }).frame(maxWidth: .infinity, maxHeight: buttonSize)
                    .padding(8)
                    .background(Color("UiGreen").opacity(0.7))
                    .cornerRadius(20)
                
                Spacer()
            }.frame(width: UIScreen.main.bounds.width)
                .padding(2)
        }.navigationBarHidden(true)
            .environmentObject(user)
    }
}

// They were originally here
// left for survey list temporary reference if needed
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

struct Profile: View {
    @State private var isLoggedOut: Bool = false
    
    var body: some View {
        NavigationLink(destination: SetupView(), isActive: $isLoggedOut, label: { EmptyView() })
        
        NavigationView {
            ScrollView(showsIndicators: false) {
                ZStack {
                    Rectangle()
                        .fill(Color("Profile Grey"))
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    
                    VStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 45, style: .continuous)
                            .fill(Color("UiGreen").opacity(0.5))
                        .frame(width: UIScreen.main.bounds.width, height: 260)
                        .ignoresSafeArea()
                        Spacer()
                    }
                   
                    VStack {
                        Spacer()
                            .frame(height: 20.0)
                        Image("Profile Photo")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 27.0))
                        
                        Text("Me")
                            .foregroundColor(Color("Profile Name Color"))
                            .font(.custom("TitilliumWeb-Black", size: 24))                        

                        ZStack {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(Color.white)
                                .frame(width: UIScreen.main.bounds.width - UIScreen.main.bounds.width / 5, height: 130)
                            .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 0.5)
                            VStack(alignment: .leading) {
                                Text("Travel information")
                                    .foregroundColor(Color.black)
                                    .font(.custom("TitilliumWeb-Bold", size: 14))
                                Spacer().frame(height: 10)
                                HStack {
                                    HStack {
                                        VStack {
                                            Image("Personal Vehicle")
                                                .resizable()
                                            .frame(width: 18, height: 16)
                                            Text("")
                                        }
                                        Spacer().frame(width: 10)
                                        VStack(alignment: .leading) {
                                            Text("Add Car")
                                                .font(.custom("TitilliumWeb-SemiBold", size: 18))
                                            Text("Personal Vehicle")
                                                .foregroundColor(Color.gray)
                                                .font(.custom("TitilliumWeb-SemiBold", size: 12))
                                        }
                                    }
                                    Spacer().frame(width: UIScreen.main.bounds.width / 6)
                                    HStack {
                                        VStack {
                                            Image("Residence")
                                                .resizable()
                                            .frame(width: 20, height: 17)
                                            Text("")
                                        }
                                        Spacer().frame(width: 10)
                                        VStack(alignment: .leading) {
                                            Text("Home")
                                                .font(.custom("TitilliumWeb-SemiBold", size: 18))
                                            Text("Residence")
                                                .foregroundColor(Color.gray)
                                                .font(.custom("TitilliumWeb-SemiBold", size: 12))
                                        }
                                    }
                                }
                            }
                        }
                        Spacer()
                        ZStack {
                            Rectangle()
                                .fill(Color("UiGreen").opacity(0.7))
                                .frame(width: 282, height: 50)
                            Button("LOG OUT") {
                                isLoggedOut = FirebaseManager.handleLogout()
                            }
                                .font(.custom("PTMono-Bold", size: 18))
                                .foregroundColor(.white)
                            
                        }.navigationBarBackButtonHidden(true)
                            .padding(.bottom, 10)
                        Spacer()
                    }
                }
                
                /*
                // left for temporary survey list reference
                // They were originally in this struct
                List {
                    VStack {
                        Route(title: "Signup survey", subTitle: "Link: ")
                            .padding(.bottom, 10)
                        Route(title: "Midterm survey", subTitle: "Link: ")
                            .padding(.bottom, 10)
                    }
                }
                .listStyle(GroupedListStyle())
                 */
                
            }.navigationBarHidden(true)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(User())
    }
}