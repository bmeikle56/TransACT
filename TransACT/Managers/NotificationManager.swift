//
//  NotificationManager.swift
//  TransACT
//
//  Created by Shuangyue Cheng on 2/28/22.
//

import UserNotifications
import SwiftUI

class NotificationManager: NSObject, ObservableObject {
    
    //@Published var requestedAuthorization: Bool?
    // change to ensure it stablized
    // access this notification manager anywhere inside the app
    static let shared = NotificationManager()
    var notificationEnabled: Bool = false
    let center = UNUserNotificationCenter.current()
    
    func updateNotificationEnabled() {
        self.center.getNotificationSettings{ (settings) in
            self.notificationEnabled = settings.authorizationStatus == .authorized
        }
    }
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        center.requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("DEBUG: ERROR: \(error)")
            } else {
                print("SUCCESS")
                self.center.getNotificationSettings{ (settings) in
                    self.notificationEnabled = settings.authorizationStatus == .authorized
                }
            }
        }
        
    }
}
