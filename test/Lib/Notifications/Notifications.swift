//
//  Notifications.swift
//  test
//
//  Created by Octavio Lara on 18/04/2025.
//

import UserNotifications

struct Notifications {
    static func requestPermission() {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(
                options: [.alert, .sound,. badge]
            ){ granted, error in
                if let error = error {
                    print("Error requesting permission: \(error)")
                } else {
                    print("Permission granted: \(granted)")
                }
        }
    }
    static func scheduleNotificatiuon(
        for plantName: String,
        at date: Date,
        identifier id: String
    ){
        let content = UNMutableNotificationContent()
        content.title = "Time to water your plant 🌱"
        content.body = "Don't forget to water \(plantName)"
        content.sound = .default
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: id,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request){ error in
            if let error = error {
                print("Error creating the notification: \(error)")
            } else {
                print("Notification Scheduled!")
            }
        }
    }
    static func removeNotification(identifier id: String){
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [id])
    }
}
