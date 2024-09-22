//
//  ImageForCatChoice.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 18.09.2024.
//

import Foundation
import SwiftUI
struct ImageForCatChoice: View {
    let imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
    }
}
#Preview{
    ImageForCatChoice(imageName: "artiomkaCatChoosingButton")
}
//meow
