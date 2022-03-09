//
//  NotificationManager.swift
//  VIPapplication
//
//  Created by Shuangyue Cheng on 2/28/22.
//

import UserNotifications
import SwiftUI

class NotificationManager: NSObject, ObservableObject {
    
    //@Published var requestedAuthorization: Bool?
    // access this notification manager anywhere inside the app
    static let shared = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("DEBUG: ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
    }
}
