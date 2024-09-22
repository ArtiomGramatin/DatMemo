//
//  CatChoosingButton.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 30.04.2024.
//

import SwiftUI

struct CatChoosingButton: View {
    @ScaledMetric(relativeTo: .body) var scaledPadding: CGFloat = 20
    @ScaledMetric(relativeTo: .body) var scaledframewidth: CGFloat = 160
    @ScaledMetric(relativeTo: .body) var scaledframeheight: CGFloat = 60
    @ScaledMetric(relativeTo: .body) var scaledframeButtonHeight: CGFloat = 100
    @ScaledMetric(relativeTo: .body) var scaledframeButtonWidth: CGFloat = 250
    @ScaledMetric(relativeTo: .body) var scaledframeDefaultSizeOne: CGFloat = 1
    var body: some View {
        Button {
            print("Edit button was tapped")
        } label: {
            Image("ChooseButtonCats")
                .resizable()
        }
        .frame(width: scaledframewidth, height: scaledframewidth)
    }
}

#Preview {
    CatChoosingButton()
}
