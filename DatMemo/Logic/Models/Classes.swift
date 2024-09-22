//
//  Classes.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 22.07.2024.
//

import Foundation

class yourchosencat: ObservableObject {
    @Published var ychosenCat: Int8 = 0 {
        didSet {
            SettingsManager.shared.saveYourChoice(ychosenCat)
        }
    }

    init() {
        self.ychosenCat = SettingsManager.shared.getYourChoice()
    }
}
class partnerschosencat: ObservableObject {
    @Published var pchosenCat: Int8 = 0 {
        didSet {
            SettingsManager.shared.savePartnersChoice(pchosenCat)
        }
    }

    init() {
        self.pchosenCat = SettingsManager.shared.getPartnersChoice()
    }
}

class Username: ObservableObject {
    @Published var username: String = SettingsManager.shared.getUsername() {
        didSet {
            if username.count > 9 {
                username = String(username.prefix(9))
            }
            SettingsManager.shared.saveUsername(username)
        }
    }
}

class Partnersname: ObservableObject {
    @Published var partnersname: String = SettingsManager.shared.getPartnersname() {
        didSet {
            if partnersname.count > 9 {
                partnersname = String(partnersname.prefix(9))
            }
            SettingsManager.shared.savePartnersname(partnersname)
        }
    }
}
