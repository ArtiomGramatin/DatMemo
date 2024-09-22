import Foundation
import UIKit
import SwiftUI


class SettingsManager {
    static let shared = SettingsManager()

    private let fileName = "userSettings.json"
    private var fileURL: URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent(fileName)
    }

    private init() {
        createFileIfNeeded() // Ensure the file is created if it doesn't exist
        loadSettings() // Load settings when the manager is initialized
    }

    // User settings data structure
    struct UserSettings: Codable {
        var username: String
        var partnersname: String
        var yourChoice: Int8
        var partnersChoice: Int8
        var images: [String: Data] // Stores images as Data objects
    }

    private var userSettings = UserSettings(username: "", partnersname: "", yourChoice: 0, partnersChoice: 0, images: [:])

    // Ensure the settings file exists
    private func createFileIfNeeded() {
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                // Create an empty UserSettings object and write to file
                let initialSettings = UserSettings(username: "", partnersname: "", yourChoice: 0, partnersChoice: 0, images: [:])
                let data = try JSONEncoder().encode(initialSettings)
                FileManager.default.createFile(atPath: fileURL.path, contents: data, attributes: nil)
            } catch {
                print("Failed to create settings file: \(error.localizedDescription)")
            }
        }
    }

    // Load settings from file
    func loadSettings() {
        do {
            let data = try Data(contentsOf: fileURL)
            userSettings = try JSONDecoder().decode(UserSettings.self, from: data)
        } catch {
            print("Failed to load settings: \(error.localizedDescription). Initializing with default values.")
            // Re-create the file with default settings if loading fails
            createFileIfNeeded()
        }
    }

    // Save settings to file
    private func saveSettings() {
        do {
            let data = try JSONEncoder().encode(userSettings)
            try data.write(to: fileURL)
        } catch {
            print("Failed to save settings: \(error.localizedDescription)")
        }
    }

    // Save methods
    func saveUsername(_ username: String) {
        userSettings.username = username
        saveSettings()
    }

    func savePartnersname(_ partnersname: String) {
        userSettings.partnersname = partnersname
        saveSettings()
    }

    func saveYourChoice(_ choice: Int8) {
        userSettings.yourChoice = choice
        saveSettings()
    }

    func savePartnersChoice(_ choice: Int8) {
        userSettings.partnersChoice = choice
        saveSettings()
    }

    func saveImage(_ image: UIImage, for key: String) {
        if let imageData = image.pngData() {
            userSettings.images[key] = imageData
            saveSettings()
        }
    }

    // Load methods
    func getUsername() -> String {
        return userSettings.username
    }

    func getPartnersname() -> String {
        return userSettings.partnersname
    }

    func getYourChoice() -> Int8 {
        return userSettings.yourChoice
    }

    func getPartnersChoice() -> Int8 {
        return userSettings.partnersChoice
    }

    func getImage(for key: String) -> UIImage? {
        guard let imageData = userSettings.images[key] else {
            return nil
        }
        return UIImage(data: imageData)
    }
}
