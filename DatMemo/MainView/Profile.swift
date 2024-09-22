//
//  Profile.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 29.05.2024.
//

import SwiftUI

struct Profile: View {
    let background = Image("Background")
    @ScaledMetric(relativeTo: .body) var scaledsize: CGFloat = 100
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @ObservedObject var yourchoice: yourchosencat
    @ObservedObject var username: Username
    @ObservedObject var partnersname: Partnersname
    @ObservedObject var partnerschosencat: partnerschosencat

    private func imageName(for catChoice: Int8) -> String {
        switch catChoice {
        case 1: return "artiomkaCatChoosingButton"
        case 2: return "sashenkaCatChoosingButton"
        case 3: return "dimaCatChoosingButton"
        default: return "ChooseButtonCats"
        }
    }

    var body: some View {
        GeometryReader { geometry in
            let isSmallDevice = geometry.size.height < 667
            NavigationView {
                ZStack {
                    background
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                    
                    VStack {
                        HStack(alignment: .center) {
                            CustomBackButton {
                                self.mode.wrappedValue.dismiss()
                            }
                            .padding(.trailing, isSmallDevice ? -5 : -10)
                            
                            NavigationLink(destination: settingsview(username: username, partnersname: partnersname, yourchoice: yourchoice, partnerschosencat: partnerschosencat)
                                            .environmentObject(yourchoice)
                                            .environmentObject(partnerschosencat)) {
                                HStack {
                                    Image("settingsicon")
                                        .resizable()
                                        .shadow(color: .shadowblack, radius: 0, x: 6, y: 5)
                                        .frame(width: scaledsize * (isSmallDevice ? 0.32 : 0.4), height: scaledsize * (isSmallDevice ? 0.32 : 0.4))
                                }
                                .frame(width: scaledsize * (isSmallDevice ? 0.32: 0.4), height: scaledsize * (isSmallDevice ? 0.32 : 0.4))
                                .padding(.leading, scaledsize * (isSmallDevice ? 2.25 : 2.5))
                            }
                        }
                        .padding(.top, scaledsize * (isSmallDevice ? 0.3 : 0.5))
                        
                        VStack(alignment: .center) {
                            Image(imageName(for: yourchoice.ychosenCat))
                                .resizable()
                                .frame(width: scaledsize * (isSmallDevice ? 1.3 : 1.65), height: scaledsize * (isSmallDevice ? 1.3 : 1.65), alignment: .center)
                                .shadow(color: .shadowblack, radius: 0, x: 5, y: 6)
                                .padding(.top, scaledsize * (isSmallDevice ? 0.48 : 0.68))
                            
                            Text(username.username)
                                .font(Font.custom("PressStart2P", fixedSize: isSmallDevice ? 16 : 24))
                                .padding(.vertical, scaledsize * (isSmallDevice ? 0.48 : 0.53))
                                .foregroundColor(.white)
                            
                            Image(imageName(for: partnerschosencat.pchosenCat))
                                .resizable()
                                .frame(width: scaledsize * (isSmallDevice ? 1.3 : 1.65), height: scaledsize * (isSmallDevice ? 1.3 : 1.65), alignment: .center)
                                .shadow(color: .shadowblack, radius: 0, x: 5, y: 6)
                            
                            Text(partnersname.partnersname)
                                .font(Font.custom("PressStart2P", fixedSize: isSmallDevice ? 16 : 24))
                                .padding(.top, scaledsize * (isSmallDevice ? 0.48 : 0.53))
                                .foregroundColor(.white)
                        }
                        .padding(.bottom, scaledsize * (isSmallDevice ? 0.8 : 1))
                    }
                }
            }
            .navigationBarHidden(true)
            .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                if value.startLocation.x < 20 && value.translation.width > 100 {
                    self.mode.wrappedValue.dismiss()
                }
            }))
        }
    }
}

struct CustomBackButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "arrow.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .foregroundColor(.white)
                .padding()
                .shadow(color: .shadowblack, radius: 0, x: 2, y: 3)
        }
    }
}

#Preview{
    Profile(yourchoice: yourchosencat(), username: Username(), partnersname: Partnersname(), partnerschosencat: partnerschosencat())
}

