//
//  SurveyListView.swift
//  VIPapplication
//
//  Created by Chengkai Yao on 2/27/22.
//

import SwiftUI
import FirebaseFirestore


struct SurveyListView: View {
    
    @EnvironmentObject var user: User
    var buttonSize:CGFloat = 45;
    @State var isShowingMapBoxMapView = false
    @State var surveys: [Survey] = []
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
            ZStack(alignment: .top) {
                
                RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color.white)
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
            
            NavigationView {
                List {
                    
                    ForEach(surveys){survey in
                        Link(destination: URL(string: survey.url)!) {
                        ZStack() {
                            RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color.white)
                                .frame(maxWidth: UIScreen.main.bounds.width * 0.9, maxHeight: 80)
                                .shadow(radius: 5, x: 0, y: 2)
                            VStack(alignment: .leading) {
                                Text(survey.name)
                                    .font(.system(size: 20, weight: .bold, design: .default))
                                if survey.finished {
                                    Text("finished")
                                        .italic()
                                        .frame(width: UIScreen.main.bounds.width * 0.8, alignment: .leading)
                                    
                                }
                                else {
                                    Text("")
                                        .italic()
                                        .frame(width: UIScreen.main.bounds.width * 0.8, alignment: .leading)
                                }
                                
                            }
                        }
                        }.listRowSeparator(.hidden)
                            .frame(width: UIScreen.main.bounds.width, height: 100)
                            .listRowInsets(EdgeInsets())
                    }
                    .navigationTitle("")
                    .navigationBarTitleDisplayMode(.inline)
                    
                }
                
                .listStyle(.plain)
                .frame(maxWidth: .infinity, alignment: .leading)
                //.navigationBarHidden(true)
                
            }
            .task {
                await fetchData()
            }
            .refreshable {
                await fetchData()
            }
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
    
    func fetchData()async {
        do {
            self.surveys = []
            let db = Firestore.firestore()
            let _ = db.collection("surveys").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting surveys: \(err)")
                } else {
                    db.collection("users").document(user.uid).getDocument() { (document, erro) in
                        if let erro = erro {
                            print("Error getting user surveys: \(erro)")
                        } else {
                            let survey_finished = Set<String>((document?.data()?["survey_finished"] ?? "nil") as! [String])
                            
                            for survey in querySnapshot!.documents {
                                print(survey.data())
                                if survey_finished.contains(survey.documentID) {
                                    self.surveys.append(Survey(id: survey.documentID,
                                                               name: survey.data()["name"] as? String ?? "",
                                                               url: survey.data()["url"] as? String ?? "https://www.apple.com", finished: true))
                                }
                                else {
                                    self.surveys.append(Survey(id: survey.documentID,
                                                               name: survey.data()["name"] as? String ?? "",
                                                               url: survey.data()["url"] as? String ?? "https://www.apple.com", finished: false))
                                }
                                
                                
                                
                            }
                        }
                    }
                    
                    
                    
                    print(surveys)
                }
                
                
            }
        }
    }
    
}

struct Survey: Identifiable, Codable {
    var id = UUID().uuidString
    var name: String
    var url: String
    var finished: Bool
}


struct SurveyListView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyListView().environmentObject(User())
    }
}
