//
//  RequestPushNotif.swift
//  TransACT
//
//  Created by Shuangyue Cheng on 2/22/22.
//

import SwiftUI

struct RequestPushNotifView: View {
    
    @EnvironmentObject var user: User
    @ObservedObject var notificationManager = NotificationManager.shared
    @AppStorage("NotificationPushInitialRequest") var initialRequestDone: Bool = false
    
    var body: some View {
            
        // change to accordingly show the announcement push request based on real settings
        // settings.alertSetting == .enabled
        VStack {
            Spacer()
                .frame(height: 55.0)
            Image("LocationSharing")
                .resizable()
                .frame(width: 339.0, height: 241.0)
            
            Spacer()
                .frame(height: 50.0)
            
            Text("Don't miss out!")
                .font(.custom("Ramaraja", size: 30))
                .multilineTextAlignment(.leading)
                .frame(width: 300, height: 55, alignment: .bottomLeading)
            
            Text("This app uses push notifications to remind users to complete research tasks such as completing survey.")
                .font(.custom("Ramaraja", size: 20))
                .multilineTextAlignment(.leading)
                .frame(width: 300, height: 140, alignment: .leading)
            
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
            
            Spacer()
                .frame(height: 20)
            
//            NavigationLink(destination: MainTabView()) {
//                Text("Skip for now")
//                    .font(.custom("PTMono-Bold", size: 18))
//                    .foregroundColor(.black)
//            }
            
            Spacer()
                .frame(height: 20.0)
            
            if initialRequestDone {
                NavigationLink(destination: MainTabView(), label: {})
            }
        }
            .navigationBarHidden(true)
            .environmentObject(user)
    }
}

struct RequestPushNotif_Previews: PreviewProvider {
    static var previews: some View {
        RequestPushNotifView().environmentObject(User())
    }
}
