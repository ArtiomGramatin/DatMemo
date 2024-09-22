//
//  Heart.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 31.07.2024.
//

import SwiftUI

struct Heart: View {
    @ObservedObject var username: Username
    @ObservedObject var partnersname: Partnersname
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ScaledMetric(relativeTo: .body) var scaledsize: CGFloat = 100
    var body: some View {
        GeometryReader { geometry in
            let isSmallDevice = geometry.size.height < 667
            HStack(alignment: .center) {
                Text(username.username)
                    .padding(sides: [.left], value: scaledsize * (isSmallDevice ? 0.08 : 0.095))
                    .font(Font.custom("PressStart2P", fixedSize: (isSmallDevice ? 7.6 : 7.6)))
                    .foregroundColor(Color.brownnr2)
                    .frame(width: scaledsize * (isSmallDevice ? 1.064 : 1.064), height: scaledsize * (isSmallDevice ? 0.076 : 0.076), alignment: .trailing)
                    .shadow(color: .shadowblack, radius: 0, x: 1, y: 1)

                Image("heart")
                    .resizable()
                    .frame(width: scaledsize * (isSmallDevice ? 0.46 : 0.6), height: scaledsize * (isSmallDevice ? 0.4 : 0.56), alignment: .center)
                    .shadow(color: .shadowblack, radius: 0, x: 2, y: 3)

                Text(partnersname.partnersname)
                    .multilineTextAlignment(.leading)
                    .padding(sides: [.left], value: scaledsize * (isSmallDevice ? 0.08 : 0.095))
                    .font(Font.custom("PressStart2P", fixedSize: (isSmallDevice ? 7.6 : 7.6)))
                    .foregroundColor(Color.brownnr2)
                    .frame(width: scaledsize * (isSmallDevice ? 1.064 : 1.064), height: scaledsize * (isSmallDevice ? 0.076 : 0.076), alignment: .leading)
                    .shadow(color: .shadowblack, radius: 0, x: 1, y: 1)
            }
            .frame(width: isSmallDevice ? 432 : 432, height: isSmallDevice ? 56 : 56, alignment: .center)
            
        }
        }
        
        
}

#Preview {
    Heart(username: Username(), partnersname: Partnersname())
}
