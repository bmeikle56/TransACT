//
//  MapView.swift
//  SwiftUIPractice
//
//  Created by Braeden Meikle on 2/13/22.
//

import SwiftUI
import MapboxMaps
import FirebaseFirestore

struct MapBoxMapView: View {
    
    @EnvironmentObject var user: User
    
    var buttonSize:CGFloat = 45;
    
    @State var survey_to_finish = [String]()
    @State var isShowingSurveyListView = false
    
    func checkSurvey() {
        let db = Firestore.firestore()
        let currUser = db.collection("users").document(user.uid)
        currUser.getDocument { (document, error) in
            if let error = error {
                print("Error getting user \(user.uid) : \(error)")
            }
            else {
                db.collection("surveys").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting surveys: \(err)")
                    } else {
                        var surveys = Set<String>()
                        for survey in querySnapshot!.documents {
                            print("\(survey.documentID) => \(survey.data())")
                            surveys.insert(String(survey.documentID))
                        }
                        
                        print(surveys)
                        let survey_finished = Set<String>((document?.data()?["survey_finished"] ?? "nil") as! [String])
                        print(survey_finished)
                        for survey in surveys {
                            if !survey_finished.contains(survey) {
                                print("not finished: \(survey)")
                                survey_to_finish.append(survey)
                            }
                        }
                    }
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                MapBoxMapViewController()
                    .scaledToFill()
                
                RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color.white)
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
            
            HStack {
                Spacer()
                NavigationLink(destination: SurveyListView(), isActive: $isShowingSurveyListView) { EmptyView() }
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
                    // Do something...
                }, label: {
                    Image("Location icon white")
                        .resizable()
                        .frame(maxWidth: buttonSize)
                        .aspectRatio(contentMode: .fit)
                    
                }).frame(maxWidth: .infinity, maxHeight: buttonSize)
                    .padding(8)
                    .background(Color("UiGreen").opacity(0.7))
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




struct MapBoxMapViewController: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> MapViewController {
        return MapViewController()
    }
    
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
    }
}


class MapViewController: UIViewController {
    
    
    
    internal var mapView: MapView!
    override public func viewDidLoad() {
        super.viewDidLoad()
        let myResourceOptions = ResourceOptions(accessToken: "sk.eyJ1IjoiYm1laWtsZTMiLCJhIjoiY2t6bGh2cTN4NTJnaDJycDR3Zjlob3pmbiJ9.jvnZBZifWQN4zuApx979Ug")
        let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions)
        
        mapView = MapView(frame: view.bounds, mapInitOptions: myMapInitOptions)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(mapView)
        
    }
}

struct MapBoxMapView_Previews: PreviewProvider {
    static var previews: some View {
        MapBoxMapView().environmentObject(User()).previewInterfaceOrientation(.portrait)
    }
}
