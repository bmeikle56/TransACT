//
//  ResetPasswordView.swift
//  VIPapplication
//
//  Created by Braeden Meikle on 2/20/22.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @State private var email: String = ""
    @State private var showAlert: Bool = false
    
    // used for returning back to a previous view
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Text("RESET PASSWORD")
                .padding(.bottom, 100)
                .font(.custom("PTMono-Regular", size: 36))
            
            ZStack {
                TextField(
                       "Email",
                       text: $email
                )
                    .autocapitalization(.none)
                    .frame(width: 250, height: 15, alignment: .center)
                    .padding()
                    .background(Color(.systemGray6))
                    .font(.custom("PTMono-Regular", size: 18)).multilineTextAlignment(.center)
            }
            
            ZStack {
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 282, height: 50)
                
                Button("GET RESET EMAIL") {
                    showAlert = true
                }.alert(isPresented: $showAlert) {
                    // alert user an email was sent and send them back to the login page to try again
                    Alert (title: Text("Email was sent!"),
                           message: Text("Check your email for instructions on how to reset your password"),
                           dismissButton: .default(
                            Text("Return to login"),
                            action: {
                                self.presentationMode.wrappedValue.dismiss()
                        
                    }))
                }.font(.custom("PTMono-Regular", size: 18))
                    .foregroundColor(.white)
                
            }.navigationBarBackButtonHidden(true)
                .padding(.bottom, 10)
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
