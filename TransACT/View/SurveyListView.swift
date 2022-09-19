//
//  SurveyListView.swift
//  TransACT
//
//  Created by Chengkai Yao on 2/27/22.
//

import SwiftUI
import WebKit

struct SurveyListView: View {
    
    @EnvironmentObject var user: User
    var buttonSize: CGFloat = 45;
    
    /*init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.shadowColor = .clear
        navBarAppearance.backgroundColor = UIColor.white
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }*/
    
    var body: some View {
        VStack {
            SurveyList()
                .environmentObject(user)
        }
            .navigationBarHidden(true)
            .environmentObject(user)
    }
}

struct SurveyList: View {
    
    @State var surveys: [SurveyItem] = []
    @EnvironmentObject var user: User
    
    var body: some View {
        VStack {
            List(self.surveys) {survey in
                Survey(survey: survey)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                }
                    .navigationTitle("")
                    .navigationBarTitleDisplayMode(.inline)
                    .listStyle(.plain)
        }.background(Color(.systemGray6))
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

