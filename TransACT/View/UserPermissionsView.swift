//
//  UserPermissionsView.swift
//  TransACT
//
//  Created by Braeden Meikle on 4/19/22.
//

import SwiftUI

struct UserPermissionsView: View {
    
    @EnvironmentObject var user: User
    @ObservedObject var locationManager = LocationManager.shared
    @ObservedObject var notificationManager = NotificationManager.shared
    @AppStorage("NotificationPushInitialRequest") var initialRequestDone: Bool = false
    
    func passUserToLocationManager() {
        locationManager.setUser(user: user)
    }
    
    var body: some View {
        
        /*if locationManager.userLocation != nil {
            // if user denied -> userLocation is nil
            UserPermissionsView().task {
                passUserToLocationManager()
            }
        }*/
        
        VStack {
            Image("LocationSharing")
                .resizable()
                .frame(width: 300, height: 200)
            Spacer().frame(height: 30)
            Text("Share location data and allow push notifications")
                .font(.custom("PTMono-Bold", size: 30))
                .multilineTextAlignment(.center)
            Spacer().frame(height: 30)
            // [Learn more about this requirement.](https://www.apple.com)
            /*Text("This app collects location services to understand the congestion distribution. By enabling the location, you are providing access to Georgia Tech researchers to use the data for future studies. You can opt out of the study at any time.")
                .font(.custom("Ramaraja", size: 19))
                .multilineTextAlignment(.leading)
                .frame(width: 300, height: 200, alignment: .topLeading)*/
            /*Text("Get push notifications for available incentives, research updates and other activities going on! [Learn more about this requirement.](https://www.apple.com)")
                .font(.custom("Ramaraja", size: 20))
                .multilineTextAlignment(.leading)
                .frame(width: 300, height: 140, alignment: .leading)*/
            
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
            Button(action: {
                notificationManager.requestAuthorization()
                initialRequestDone = true
                // UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }, label: {
                ZStack {
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: 282, height: 50)
                    Text("Enable notifications")
                        .font(.custom("PTMono-Bold", size: 18))
                        .foregroundColor(.white)
                }
            })
            Spacer().frame(height: 20)
//            NavigationLink(destination: MainTabView()) {
//                Text("Skip for now")
//                    .font(.custom("PTMono-Regular", size: 18))
//                    .foregroundColor(.black)
//            }
            Spacer().frame(height: 40)
            HStack(spacing: 50) {
                Image("PeachTreeCornersLogo")
                    .resizable()
                    .frame(width: 70.0, height: 94.5)
                Image("GTLogo")
                    .resizable()
                    .frame(width: 90.0, height: 90.0)
            }
            
            /*if initialRequestDone {
                NavigationLink(destination: MainTabView(), label: {})
            }*/
        }
            .navigationBarHidden(true)
            .environmentObject(user)
    }
}

struct UserPermissionsView_Previews: PreviewProvider {
    static var previews: some View {
        UserPermissionsView().environmentObject(User())
    }
}
