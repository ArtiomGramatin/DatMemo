//
//  TextEditorView.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 29.06.2024.
//

import SwiftUI

struct TextEditorView: View {
    @Binding var text: String
    var onSave: (String) -> Void
    let maxCharacters = 200
    let backgroundColor = Color(.color2) // Custom color
    let borderColor = Color.gray
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ZStack {
                Color.color1
                    .ignoresSafeArea()
                VStack {
                    // Text Editor for User Input
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $text)
                            .padding()
                            .background(.color2)
                            .frame(width: 266, height: 237)
                            .font(Font.custom("PressStart2P", size: 12))
                            .cornerRadius(10)
                    
                    }
                    .padding()
                    
                    // Character count display
                    HStack {
                        Spacer()
                        Text("\(text.count)/\(maxCharacters)")
                            .font(Font.custom("PressStart2P", size: 12))
                            .foregroundColor(text.count > maxCharacters ? .red : .color2)
                            .padding(.trailing, 45)
                    }
                    
                    // Save Button
                    Button("Save") {
                        if text.count <= maxCharacters {
                            onSave(text)
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .padding()
                    .background(text.count <= maxCharacters ? Color.color2 : Color.browney)
                    .foregroundColor(.white)
                    .cornerRadius(6)
                    .disabled(text.count > maxCharacters)
                }
                .padding()
                .font(Font.custom("PressStart2P", size: 12))
            }
        }
    }
}

#Preview {
    TextEditorView(text: .constant("text"), onSave: { _ in })
}
