//
//  RequestLocationNotif.swift
//  VIPapplication
//
//  Created by Shuangyue Cheng on 2/22/22.
//

import SwiftUI

struct RequestLocationNotifView: View {
    
    @EnvironmentObject var user: User
    @ObservedObject var locationManager = LocationManager.shared
    
    func passUserToLocationManager() {
        locationManager.setUser(user: user)
    }
    
    var body: some View {
        Group {
            if locationManager.userLocation != nil {
                // if user denied -> userLocation is nil
                RequestPushNotifView().task {
                    passUserToLocationManager()
                }
            } else {
                    NavigationView {
                        ScrollView(showsIndicators: false) {
                            ZStack {
                                VStack {
                                    Spacer()
                                        .frame(height: 25.0)
                                    Image("LocationSharing")
                                        .resizable()
                                        .frame(width: 339.0, height: 241.0)
                                    
                                    Spacer()
                                        .frame(height: 20.0)
                                    
                                    Text("Share Location!")
                                        .font(.custom("Ramaraja", size: 30))
                                        .multilineTextAlignment(.leading)
                                        .frame(width: 300, height: 55, alignment: .bottomLeading)
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
                                        Text("Enable Location Always")
                                            .foregroundColor(.white)
                                            .font(.custom("Ramaraja", size: 20))
                                            .multilineTextAlignment(.center)
                                            .background(Rectangle()
                                                            .fill(Color("UiGreen"))
                                                            .frame(width: 300, height: 55))
                                    })
                                        .padding(2.0)
                                    
                                    Spacer()
                                        .frame(height: 28.0)
                                    
                                    NavigationLink(destination: RequestPushNotifView()) {
                                        Text("Skip for now")
                                            .font(.custom("Ramaraja", size: 18))
                                            .foregroundColor(Color.init(UIColor.gray))
                                    }.padding(-8)
                                    
                                    HStack(spacing: 140) {
                                        Image("PeachTreeCornersLogo")
                                            .resizable()
                                            .frame(width: 70.0, height: 94.5)
                                        Image("GTLogo")
                                            .resizable()
                                            .frame(width: 90.0, height: 90.0)
                                    }
                                }
                            }
                        }.navigationBarHidden(true)
                            .environmentObject(user)
                    }.navigationBarHidden(true)
                }
        }
    }
}

struct RequestLocationNotif_Previews: PreviewProvider {
    static var previews: some View {
        RequestLocationNotifView().environmentObject(User())
    }
}
