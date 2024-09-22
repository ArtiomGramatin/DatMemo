//
//  permissions.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 23.07.2024.
//

import Foundation
import UserNotifications
import AVFoundation
import Photos
import Contacts

class PermissionsManager {
    
    static let shared = PermissionsManager()
    
    private init() {}
    
    // Function to request all permissions with completion handlers
    func requestAllPermissions(completion: @escaping (Bool, [String]) -> Void) {
        var grantedPermissions = [String]()
        var deniedPermissions = [String]()
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        requestNotificationPermission { granted in
            if granted {
                grantedPermissions.append("Notifications")
            } else {
                deniedPermissions.append("Notifications")
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        requestCameraPermission { granted in
            if granted {
                grantedPermissions.append("Camera")
            } else {
                deniedPermissions.append("Camera")
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        requestPhotoLibraryPermission { granted in
            if granted {
                grantedPermissions.append("Photo Library")
            } else {
                deniedPermissions.append("Photo Library")
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        requestContactsPermission { granted in
            if granted {
                grantedPermissions.append("Contacts")
            } else {
                deniedPermissions.append("Contacts")
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(deniedPermissions.isEmpty, deniedPermissions)
        }
    }
    
    // Request Notification Permission
    private func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting notifications permission: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(granted)
            }
        }
    }
    
    // Request Camera Permission
    private func requestCameraPermission(completion: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            completion(granted)
        }
    }
    
    // Request Photo Library Permission
    private func requestPhotoLibraryPermission(completion: @escaping (Bool) -> Void) {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized, .limited:
                completion(true)
            case .denied, .restricted, .notDetermined:
                completion(false)
            @unknown default:
                completion(false)
            }
        }
    }
    
    // Request Contacts Permission
    private func requestContactsPermission(completion: @escaping (Bool) -> Void) {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { granted, error in
            if let error = error {
                print("Error requesting contacts permission: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(granted)
            }
        }
    }
}
