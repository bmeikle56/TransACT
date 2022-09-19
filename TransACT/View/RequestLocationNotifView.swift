//
//  RequestLocationNotif.swift
//  TransACT
//
//  Created by Shuangyue Cheng on 2/22/22.
//

import SwiftUI

struct RequestLocationNotifView: View {
    
    @EnvironmentObject var user: User
    @ObservedObject var locationManager = LocationManager.shared
    @State private var showRequestPushNotifView: Bool = false
    
    func passUserToLocationManager() {
        locationManager.setUser(user: user)
    }
    
    var body: some View {
        
        NavigationLink(destination: RequestPushNotifView(), isActive: $locationManager.locationEnabled, label: { EmptyView() }).navigationBarHidden(true)
            .environmentObject(user)
        
        if (locationManager.locationEnabled) {
            EmptyView()
        }
        else {
            VStack {
                
                Spacer()
                    .frame(height: 25.0)
                Image("LocationSharing")
                    .resizable()
                    .frame(width: 300, height: 200)
                
                Spacer()
                    .frame(height: 20.0)
                
                Text("Share Location!")
                    .font(.custom("Ramaraja", size: 30))
                    .multilineTextAlignment(.leading)
                    .frame(width: 300, height: 55)
                
                // [Learn more about this requirement.](https://www.apple.com)
                Text("This app collects location services to understand the congestion distribution. By enabling the location, you are providing access to Georgia Tech researchers to use the data for future studies. You can opt out of the study at any time.")
                    .font(.custom("Ramaraja", size: 19))
                    .multilineTextAlignment(.leading)
                    .frame(width: 300, height: 200, alignment: .topLeading)
                
                Button(action: {
                    locationManager.requestLocation()
                    passUserToLocationManager()
                    // UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }, label: {
                    ZStack {
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: 282, height: 50)
                        Text("Enable location")
                            .font(.custom("PTMono-Bold", size: 18))
                            .foregroundColor(.white)
                    }
                })
                
                Spacer()
                    .frame(height: 40)
                HStack(spacing: 50) {
                    Image("PeachTreeCornersLogo")
                        .resizable()
                        .frame(width: 70.0, height: 94.5)
                    Image("GTLogo")
                        .resizable()
                        .frame(width: 90.0, height: 90.0)
                }
                
            }.navigationBarHidden(true)
                .environmentObject(user)
        }
        }
        
        /*if locationManager.userLocation != nil {
            // if user denied -> userLocation is nil
            RequestPushNotifView().task {
                passUserToLocationManager()
            }
        }*/
        
        
        
}

struct RequestLocationNotif_Previews: PreviewProvider {
    static var previews: some View {
        RequestLocationNotifView().environmentObject(User())
    }
}
