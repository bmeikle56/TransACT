//
//  LocationManager.swift
//  VIPapplication
//
//  Created by Shuangyue Cheng on 2/28/22.
//

import CoreLocation
import FirebaseFirestore

class LocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    // published variable used for taking user to other screens when request is set
    @Published var userLocation: CLLocation?
    // access this location manager anywhere inside the app
    static let shared = LocationManager()
    var user = User()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
    
    func requestLocation() {
        // most common use for better performance and battery
        manager.requestAlwaysAuthorization()
    }
    
    func setUser(user: User) {
        self.user = user
    }
}

extension LocationManager: CLLocationManagerDelegate {
    // everytime authorization changes, this func is called
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status:
                         CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            print("DEBUG: not determined")
        case .restricted:
            print("DEBUG: restricted")
        case .denied:
            // don't allow results in denied
            print("DEBUG: denied")
        case .authorizedAlways:
            // results from allow in app, return as always
            print("DEBUG: auth always")
            manager.startUpdatingLocation()
        case .authorizedWhenInUse:
            // results from allow once
            print("DEBUG: auth in use")
            manager.startUpdatingLocation()
        @unknown default:
            print("DEBUG: default")
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // recieve user location
        guard let location = locations.last else {return}
        self.userLocation = location
        //temporarily commented to test other functions
        //print(locations)
        //print(user.uid)
        
        let altitude = location.altitude
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        // get the larger possible error
        let verticalAccuracy = location.verticalAccuracy
        let horizontalAccuracy = location.horizontalAccuracy
        var accuracy = verticalAccuracy
        if (verticalAccuracy < horizontalAccuracy) {
            accuracy = horizontalAccuracy
        }
        
        let speed = location.speed
        let time = location.timestamp
        
//        let db = Firestore.firestore()
//        let currUser = db.collection("users").document(user.uid)
//        currUser.getDocument { (document, error) in
//            if let error = error {
//                print("Error getting user \(self.user.uid) : \(error)")
//            }
//            else {
//                currUser.collection("locations").document().setData(["altitude":altitude, "latitude":latitude, "longitude":longitude, "accuracy":accuracy, "speed":speed, "time":time])
//            }
//        }
    }
}
