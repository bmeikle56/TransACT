//
//  SurveyListView.swift
//  VIPapplication
//
//  Created by Chengkai Yao on 2/27/22.
//

import SwiftUI
import WebKit

struct SurveyListView: View {
    
    @EnvironmentObject var user: User
    var buttonSize:CGFloat = 45;
    
    @State var isShowingMapBoxMapView = false
    @State var isShowingProfileView = false
    
    
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.shadowColor = .clear
        navBarAppearance.backgroundColor = UIColor.white
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    
    var body: some View {
        
        VStack {
            
            // put at the top for easy access
            NavigationLink(destination: MapBoxMapView(), isActive: $isShowingMapBoxMapView) { EmptyView() }
            NavigationLink(destination: ProfileView(), isActive: $isShowingProfileView) { EmptyView() }
            
            ZStack(alignment: .top) {
                
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.white)
                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 80)
                    .shadow(radius: 5, x: 0, y: 2)
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
            
            Spacer()
                .frame(height: 50)
            
            SurveyList().environmentObject(user)
            
            HStack {
                Spacer()
                
                Button(action: {
                    // does nothing because we are already in this view
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
                    isShowingProfileView = true
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
    
    @State var surveys: [SurveyItem] = []
    @EnvironmentObject var user: User
    
    var body: some View {
        
        NavigationView {
            List(self.surveys) {survey in
                Survey(survey: survey)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    
                }
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .listStyle(.plain)
            
        }
        .task {
            await SurveyManager.fetchSurveys(user: user) { (response) in
                switch response {
                case .success(let surveys):
                    self.surveys = surveys
                case .failure(let error):
                    print(error)
                }
            }
        }
        .refreshable {
            await SurveyManager.fetchSurveys(user: user) { (response) in
                switch response {
                case .success(let surveys):
                    self.surveys = surveys
                case .failure(let error):
                    print(error)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width)
    }
    
    
}

struct Survey: View {
    
    @State var isShowingSurveyView = false
    let survey: SurveyItem

    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.white)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 80)
                .shadow(radius: 5, x: 0, y: 2)
            
            VStack {
                if survey.finished {
                    HStack {
                        Button(survey.name) {
                            isShowingSurveyView = true
                        }
                        Spacer()
                        Text("✓")
                        
                    }.font(.system(size: 26, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                }
                else {
                    HStack {
                        Button(survey.name) {
                            isShowingSurveyView = true
                        }.popover(isPresented: $isShowingSurveyView) {
                            NavigationView {
                                WebView(url: URL(string: survey.url)!)
                                    .toolbar {
                                        ToolbarItem(placement: .navigationBarLeading) {
                                            Button(action: {
                                                isShowingSurveyView = false
                                            }, label: {
                                                Label("Back", systemImage: "chevron.down")
                                                Text("Back")
                                            })
                                        }
                                    }
                            }
                        }
                        Spacer()
                        
                    }.font(.system(size: 26, weight: .regular, design: .default))
                }
                
            }.frame(maxWidth: UIScreen.main.bounds.width * 0.8)
        }
        .frame(width: UIScreen.main.bounds.width, height: 100)
    }
}

struct WebView: UIViewRepresentable {
 
    var url: URL
 
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

struct SurveyListView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyListView().environmentObject(User())
    }
}

