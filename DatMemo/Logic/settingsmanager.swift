//
//  settingsmanager.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 11.07.2024.
//
import Foundation

class SettingsManager {
    static let shared = SettingsManager()
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Username
    
    func saveUsername(_ username: String) {
        userDefaults.set(username, forKey: "username")
    }
    
    func getUsername() -> String? {
        return userDefaults.string(forKey: "username")
    }
    
    // MARK: - Partnersname
    
    func savePartnersname(_ partnersname: String) {
        userDefaults.set(partnersname, forKey: "partnersname")
    }
    
    func getPartnersname() -> String? {
        return userDefaults.string(forKey: "partnersname")
    }
    
    // MARK: - Your Choice
    
    func saveYourChoice(_ choice: Int8) {
        userDefaults.set(choice, forKey: "yourChoice")
    }
    
    func getYourChoice() -> Int8 {
        return Int8(userDefaults.integer(forKey: "yourChoice"))
    }
    
    // MARK: - Partners Choice
    
    func savePartnersChoice(_ choice: Int8) {
        userDefaults.set(choice, forKey: "partnersChoice")
    }
    
    func getPartnersChoice() -> Int8 {
        return Int8(userDefaults.integer(forKey: "partnersChoice"))
    }
}
