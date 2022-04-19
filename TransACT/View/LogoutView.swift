//
//  LogoutView.swift
//  TransACT
//
//  Created by Braeden Meikle on 4/17/22.
//

import SwiftUI

struct LogoutView: View {
        
    var body: some View {
        VStack {
            Text("YOU ARE")
                .padding()
                .multilineTextAlignment(.center)
                .lineSpacing(10)
                .font(.custom("PTMono-Bold", size: 36))
            Text("LOGGED OUT")
                .multilineTextAlignment(.center)
                .font(.custom("PTMono-Bold", size: 36))
            
            Spacer()
                .frame(height: 40)

            ZStack {
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 282, height: 50)
                NavigationLink(destination: SetupView()) {
                    Text("Return to login").font(.custom("PTMono-Bold", size: 18))
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView()
    }
}
