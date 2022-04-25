//
//  UserPermissionsView.swift
//  TransACT
//
//  Created by Braeden Meikle on 4/19/22.
//

import SwiftUI

struct UserPermissionsView: View {
    
    @EnvironmentObject var user: User
    //@ObservedObject var locationManager = LocationManager.shared
    //@ObservedObject var notificationManager = NotificationManager.shared
    //@AppStorage("NotificationPushInitialRequest") var initialRequestDone: Bool = false
    @State private var showPopup: Bool = false
    @State private var enabledPushNotif: Bool = false
    @State private var enabledLocation: Bool = false
    
    /*func passUserToLocationManager() {
        locationManager.setUser(user: user)
    }*/
    
    func requestPushNotif() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            if error != nil {
                // Handle the error here.
            }
            
            enabledPushNotif = true
            // Enable or disable features based on the authorization.
        }
    }
    
    var body: some View {
        
        /*if locationManager.userLocation != nil {
            // if user denied -> userLocation is nil
            UserPermissionsView().task {
                passUserToLocationManager()
            }
        }*/
        
        VStack {
            
            if enabledLocation && enabledPushNotif {
                // go to MainTabView
                NavigationLink(destination: MainTabView(), label: {})
            }
            
            Spacer().frame(height: 30)
            Text("Share location data and allow push notifications")
                .font(.custom("PTMono-Bold", size: 18))
                .multilineTextAlignment(.center)
            Spacer().frame(height: 30)
            Group {
                Button(action: {
                    //locationManager.requestLocation()
                    //passUserToLocationManager()
                    // UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    /*
                     
                     for location:
                     https://developer.apple.com/documentation/corelocation/requesting_authorization_for_location_services
                     ->NSLocationWhenInUsageDescription Key
                     https://developer.apple.com/documentation/bundleresources/information_property_list/nslocationwheninuseusagedescription
                     https://stackoverflow.com/questions/46193797/nslocationwheninuseusagedescription-warning-but-i-have-already-added-it
                     
                     
                     
                     */
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
                    //notificationManager.requestAuthorization()
                    //initialRequestDone = true
                    // UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    requestPushNotif()
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
            }
            Spacer().frame(height: 20)
            Group {
                NavigationLink(destination: MainTabView()) {
                    Text("Skip for now")
                        .font(.custom("PTMono-Regular", size: 18))
                        .foregroundColor(.black)
                }
                Spacer().frame(height: 20)
                Button(action: {
                    showPopup = true
                }, label: {
                    Text("Why am I seeing this?").font(.custom("PTMono-Regular", size: 18))
                }).popover(isPresented: $showPopup, content: {
                    PopupView()
                })
            }
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

struct PopupView: View {
    
    var body: some View {
        VStack {
            Image("LocationSharing")
                .resizable()
                .frame(width: 300, height: 200)
            // [Learn more about this requirement.](https://www.apple.com)
            Text("This app collects location services to understand the congestion distribution. By enabling the location, you are providing access to Georgia Tech researchers to use the data for future studies. You can opt out of the study at any time.")
                .font(.custom("Ramaraja", size: 20))
                .multilineTextAlignment(.leading)
                .frame(width: 300, height: 200, alignment: .topLeading)
            Text("Get push notifications for available incentives, research updates and other activities going on! [Learn more about this requirement.](https://www.apple.com)")
                .font(.custom("Ramaraja", size: 20))
                .multilineTextAlignment(.leading)
                .frame(width: 300, height: 140, alignment: .leading)
        }
    }
}

struct UserPermissionsView_Previews: PreviewProvider {
    static var previews: some View {
        UserPermissionsView().environmentObject(User())
    }
}
