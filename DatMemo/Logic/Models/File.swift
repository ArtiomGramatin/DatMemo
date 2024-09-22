//
//  File.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 16.07.2024.
//

import Foundation
import SwiftUI

struct CompletedDate: Codable, Identifiable {
    var id = UUID()
    var date: Date
}

enum Side: Equatable, Hashable {
    case left
    case right
}

extension View {
    func padding(sides: [Side], value: CGFloat = 8) -> some View {
        HStack(spacing: 0) {
            if sides.contains(.left) {
                Spacer().frame(width: value)
            }
            self
            if sides.contains(.right) {
                Spacer().frame(width: value)
            }
        }
    }
}
