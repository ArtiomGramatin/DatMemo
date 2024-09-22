//
//  CatChoosingView.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 30.04.2024.
//

import SwiftUI

struct CatChoosingView: View {
    let background = Image("Background")
    @ScaledMetric(relativeTo: .body) var scaledPadding: CGFloat = 20
    @ScaledMetric(relativeTo: .body) var scaledframewidth: CGFloat = 165
    @ScaledMetric(relativeTo: .body) var scaledframeheight: CGFloat = 60
    @ScaledMetric(relativeTo: .body) var scaledframeButtonHeight: CGFloat = 100
    @ScaledMetric(relativeTo: .body) var scaledframeButtonWidth: CGFloat = 250
    @ScaledMetric(relativeTo: .body) var scaledframeDefaultSizeOne: CGFloat = 1
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var catNumber: Int8 = 0
    @State private var chosenCat: Int8 = 0
    
    var body: some View {
        
        switch catNumber{
        case 1:
            Text("Hello")
        default:
            Text("No cat chosen")
        }
        ZStack{
            background
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            ZStack{
                HStack(alignment: .top) {
                    Text("")
                                    .foregroundColor(Color.white)
                                    .navigationBarBackButtonHidden(true)
                                    .navigationBarItems(leading: Button(action : {
                                        self.mode.wrappedValue.dismiss()
                                    }){
                                        Image(systemName: "arrow.left")
                                            .foregroundColor(Color.white)
                                })
                }
                        }
                        .edgesIgnoringSafeArea(.top)
                        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                        
                            if(value.startLocation.x < 20 && value.translation.width > 100) {
                                self.mode.wrappedValue.dismiss()
                            }
                            
                        }))
                VStack(alignment:.center){
                    Button {
                        print("Edit button was tapped")
                    } label: {
                        Image("artiomkaCatChoosingButton")
                            .resizable()
                    }
                    .frame(width: scaledframewidth, height: scaledframewidth)
                    .padding(.bottom, scaledPadding*1.5)
                    Button {
                        print("Edit button was tapped")
                    } label: {
                        Image("sashenkaCatChoosingButton")
                            .resizable()
                    }
                    .frame(width: scaledframewidth, height: scaledframewidth)
                    .padding(.bottom, scaledPadding*1.5)
                    Button {
                        print("Edit button was tapped")
                    } label: {
                        Image("dimaCatChoosingButton")
                            .resizable()
                    }
                    .frame(width: scaledframewidth, height: scaledframewidth)
                    
                }
            }
        }
    }

#Preview {
    CatChoosingView()
}
