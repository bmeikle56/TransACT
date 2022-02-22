//
//  RequestLocationNotif.swift
//  VIPapplication
//
//  Created by Shuangyue Cheng on 2/22/22.
//

import SwiftUI

struct RequestLocationNotif: View {
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack {
                Image("NotifTop image")
                    .resizable()
                    .frame(width: 339.0, height: 241.0)
                Spacer()
                    .frame(height: 10.0)
                Text("Share Location!")
                    .font(.custom("Ramaraja", size: 30))
                    .multilineTextAlignment(.leading)
                    .frame(width: 300, height: 55, alignment: .bottomLeading)
                // [Learn more about this requirement.](https://www.apple.com)
                Text("This app collects location services to understand the congestion distribution. By enabling the location, you are providing access to Georgia Tech researchers to use the data for future studies. You can opt out of the study at any time.")
                    .font(.custom("Ramaraja", size: 20))
                    .multilineTextAlignment(.leading)
                    .frame(width: 300, height: 250, alignment: .leading)
                Button(action: {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }, label: {
                    Text("Enable Location Always")
                        .foregroundColor(.white)
                        .font(.custom("Ramaraja", size: 20))
                        .multilineTextAlignment(.center)
                        .background(Rectangle()
                                        .fill(Color("UiGreen"))
                                        .frame(width: 300, height: 64))
                })
                    .padding(10.0)
                Spacer()
                    .frame(height: 20.0)
                HStack(spacing: 106) {
                    Image("PeachTreeCornersLogo")
                        .resizable()
                        .frame(width: 80.0, height: 108.0)
                    Image("GTLogo")
                        .resizable()
                        .frame(width: 111.0, height: 111.0)
                }
            }
        }
    }
}

struct RequestLocationNotif_Previews: PreviewProvider {
    static var previews: some View {
        RequestLocationNotif()
    }
}
