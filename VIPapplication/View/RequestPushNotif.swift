//
//  RequestPushNotif.swift
//  VIPapplication
//
//  Created by Shuangyue Cheng on 2/22/22.
//

import SwiftUI

struct RequestPushNotif: View {
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack {
                Image("NotifTop image")
                    .resizable()
                    .frame(width: 339.0, height: 241.0)
                Spacer()
                    .frame(height: 50.0)
                Text("Don't miss out!")
                    .font(.custom("Ramaraja", size: 30))
                    .multilineTextAlignment(.leading)
                    .frame(width: 300, height: 55, alignment: .bottomLeading)
                Text("Get push notifications for available incentives, research updates and other activities going on! [Learn more about this requirement.](https://www.apple.com)")
                    .font(.custom("Ramaraja", size: 20))
                    .multilineTextAlignment(.leading)
                    .frame(width: 300, height: 140, alignment: .leading)
                Button(action: {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }, label: {
                    Text("Enable Push Notifications")
                        .foregroundColor(.white)
                        .font(.custom("Ramaraja", size: 20))
                        .multilineTextAlignment(.center)
                        .background(Rectangle()
                                        .fill(Color("UiGreen"))
                                        .frame(width: 300, height: 64))
                })
                    .padding(40.0)
            }
        }
    }
}

struct RequestPushNotif_Previews: PreviewProvider {
    static var previews: some View {
        RequestPushNotif()
    }
}
