//
//  notifications.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 18.07.2024.
//

import Foundation
import UserNotifications

func scheduleNotification() {
    // Remove all pending notifications
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

    // Notification content
    let notificationContent = UNMutableNotificationContent()
    let messages = [
        "Maybe you should call them?📞",
        "Don't you miss them?🥺",
        "How was your partner's day?❤️",
        "Maybe Netflix today?😏"
    ]
    notificationContent.title = "Reminder"
    notificationContent.body = messages.randomElement() ?? "Don't forget to add new memories!"

    // Configure the trigger for 5 days from now, repeating every day after the initial 5 days
    let initialTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 60 * 60 * 24 * 5, repeats: false)
    let repeatingTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 60 * 60 * 24, repeats: true)

    // Create the initial request
    let initialRequest = UNNotificationRequest(identifier: "initialReminder", content: notificationContent, trigger: initialTrigger)
    // Create the repeating request
    let repeatingRequest = UNNotificationRequest(identifier: "repeatingReminder", content: notificationContent, trigger: repeatingTrigger)

    // Schedule the initial request with the system
    UNUserNotificationCenter.current().add(initialRequest) { error in
        if let error = error {
            print("Initial notification scheduling error: \(error.localizedDescription)")
        } else {
            print("Initial notification scheduled successfully")
        }
    }

    // Schedule the repeating request with the system
    UNUserNotificationCenter.current().add(repeatingRequest) { error in
        if let error = error {
            print("Repeating notification scheduling error: \(error.localizedDescription)")
        } else {
            print("Repeating notification scheduled successfully")
        }
    }
}

// Use scheduleNotification()
