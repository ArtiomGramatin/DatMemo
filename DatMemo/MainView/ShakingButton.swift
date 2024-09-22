//
//  ShakingButton.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 11.06.2024.
//

import SwiftUI

struct ShakingButton<Label: View>: View {
    @Binding var triggerAnimation: Bool
    let label: Label
    
    init(triggerAnimation: Binding<Bool>, @ViewBuilder label: () -> Label) {
        self._triggerAnimation = triggerAnimation
        self.label = label()
    }
    
    var body: some View {
        label
            .offset(x: triggerAnimation ? -10 : 0)
            .animation(triggerAnimation ? Animation.easeInOut(duration: 0.1).repeatCount(3, autoreverses: true) : .default, value: triggerAnimation)
            .onChange(of: triggerAnimation) { newValue in
                if newValue {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        triggerAnimation = false
                    }
                }
            }
    }
}

struct ShakingButton_Previews: PreviewProvider {
    static var previews: some View {
        ShakingButton(triggerAnimation: .constant(true)) {
            Text("Shake Me")
        }
    }
}
