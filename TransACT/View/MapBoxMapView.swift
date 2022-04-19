//
//  MapBoxMapView.swift
//  TransACT
//
//  Created by Braeden Meikle on 2/13/22.
//

import SwiftUI
import MapboxMaps

struct MapBoxMapView: View {
    
    @EnvironmentObject var user: User
    @State var survey_to_finish = [String]()
    
    func checkSurvey() {
        let db = FirebaseManager.getFirestore()
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
            MapBoxMapViewController()
        }
            .ignoresSafeArea()
            .navigationBarHidden(true)
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
        
        /* Add in info Plist:
         MGLMapboxAccessToken      String      THE-ACCESS-TOKEN-CODE
         
         replace the line below with the access token code
         
         let myResourceOptions = ResourceOptions(accessToken: "THE-ACCESS-CODE")
         */
        
        let myResourceOptions = ResourceOptions(accessToken: "THE-ACCESS-CODE")
        let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions)
        mapView = MapView(frame: view.bounds, mapInitOptions: myMapInitOptions)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(mapView)
    }
}

struct MapBoxMapView_Previews: PreviewProvider {
    static var previews: some View {
        MapBoxMapView().environmentObject(User())
    }
}
