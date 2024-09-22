//
//  DatMemoApp.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 24.04.2024.
//

import SwiftUI
import UserNotifications

@main
struct DatMemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var photoManager = PhotoManager()

    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environmentObject(photoManager)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Request notification permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else if let error = error {
                print("Failed to request notification permission: \(error.localizedDescription)")
            }
        }
        return true
    }
}
