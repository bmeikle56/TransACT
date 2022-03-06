//
//  SurveyListView.swift
//  VIPapplication
//
//  Created by Chengkai Yao on 2/27/22.
//

import SwiftUI

struct SurveyListView: View {
    
    @EnvironmentObject private var user: User
    let buttonSize: CGFloat = 45;
    @State private var isShowingMapBoxMapView: Bool = false
    
    var body: some View {
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
            
            SurveyList()
                .frame(width: UIScreen.main.bounds.width)
                
            HStack {
                Spacer()
                
                Button(action: {
                    // Do something...
                }, label: {
                    Image("Survey icon white")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                    
                    
                }).frame(maxWidth: .infinity, maxHeight: buttonSize)
                    .padding(8)
                    .background(Color("UiGreen").opacity(0.7))
                    .cornerRadius(20)
                
                NavigationLink(destination: MapBoxMapView(), isActive: $isShowingMapBoxMapView) { EmptyView() }
                
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
                    // Do something...
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

struct SurveyList: View {
    
    @State private var isShowingDummySurveyPopup: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                VStack {
                    // we will need to manually add/delete each survey, using the Survey() struct
                    Survey(title: "Signup survey", subTitle: "Link: ")
                        .padding(.bottom, 10)
                    Survey(title: "Midterm survey", subTitle: "Link: ")
                        .padding(.bottom, 10)
                    Survey(title: "Reduce emissions the easy way", subTitle: "Author: Dr. Srinivas Peeta")
                        .padding(.bottom, 10)
                }
            }
            .listStyle(GroupedListStyle())
        }
    }
}

struct Survey: View {
    
    let title: String
    let subTitle: String
    @State private var isShowingDummySurveyPopup: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.white)
                .frame(width: 350, height: 70, alignment: .center)
                .shadow(radius: 5, x: 0, y: 3)
            
            VStack {
                HStack {
                    Button(title) {
                        isShowingDummySurveyPopup = true
                    }.popover(isPresented: $isShowingDummySurveyPopup) {
                        
                        //SurveyPopup() -> save for later
                        Button(action: {
                                isShowingDummySurveyPopup = false
                            }, label: {
                                Image("X")
                            })
                                Text("Insert GT survey here")
                    }.foregroundColor(.black)
                        .padding(.leading, 10)
                        .font(.system(size: 24))
                    
                    Spacer()
                }
                HStack {
                    Text(subTitle).padding(.leading, 10)
                    
                    Spacer()
                }
            }
        }
    }
}

struct SurveyPopup: View {
    
    let xPadding: CGFloat = 100
    @State private var isShowingDummySurveyPopup: Bool = true
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                        isShowingDummySurveyPopup = false
                    }, label: {
                        Image("X")
                    })
            }.padding(.trailing, xPadding)
            
            Text("Anything else in the survey goes here")
        }
    }
}

struct SurveyListView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyListView().environmentObject(User())
    }
}
