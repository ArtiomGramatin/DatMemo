//
//  PreiewSendView.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 08.07.2024.
//
import SwiftUI

import SwiftUI

struct PreviewSendView: View {
    let date: Date
    @EnvironmentObject var photoManager: PhotoManager
    @ObservedObject var yourchoice: yourchosencat
    @ObservedObject var username: Username
    @ObservedObject var partnersname: Partnersname
    @ObservedObject var partnerschosencat: partnerschosencat

    @State private var showingShareSheet = false
    @State private var capturedImage: UIImage?
    @State private var isButtonHidden = false
    @State private var isBackButtonHidden = false
    @ScaledMetric(relativeTo: .body) var scaledsize: CGFloat = 100
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

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
            ZStack {
                Image("backgroundblur")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
//                Color(.color2)
//                    .ignoresSafeArea()

                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                        HStack {
                            CustomBackButton1 {
                                self.mode.wrappedValue.dismiss()
                            }
                            .opacity(isBackButtonHidden ? 0 : 1)
                        }
                        .offset(x: isSmallDevice ? 75 : 75)
                        .frame(width: isSmallDevice ? 42 : 42, height: isSmallDevice ? 42 : 42)
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
                        .padding(.trailing, isSmallDevice ? 39 : 29)
                        .offset(x: isSmallDevice ? -10 : -10)
                    }
                    VStack(alignment: .center) {
                        ZStack {
                            Image("backfordayview")
                                .resizable()
                                .ignoresSafeArea()
                                .shadow(color: .shadowblack, radius: 0, x: 2, y: 3)

                            VStack {
                                Text(date.formattedWithSuffix())
                                    .font(Font.custom("PressStart2P", size: 10))
                                    .foregroundColor(.white)
                                    .padding(.bottom, isSmallDevice ? 2 : 3)
                                    .padding(.top, isSmallDevice ? -10 : -10)
                                    .shadow(color: .shadowblack, radius: 0, x: 2, y: 3)

                                if let selectedPhoto = photoManager.photos[date] {
                                    ZStack {
                                        Image("textblock")
                                            .resizable()
                                            .ignoresSafeArea()
                                            .frame(width: isSmallDevice ? 187 : 237, height: isSmallDevice ? 248 : 298)
                                            .shadow(color: .shadowblack, radius: 0, x: 2, y: 3)
                                        Image(uiImage: selectedPhoto)
                                            .resizable()
                                            .scaledToFit()
                                            .ignoresSafeArea()
                                            .frame(maxWidth: isSmallDevice ? 178 : 228, maxHeight: isSmallDevice ? 248 : 288)
                                            .aspectRatio(contentMode: .fit)
                                    }
                                    
                                } else {
                                    ZStack {
                                        Image("textblock")
                                            .resizable()
                                            .ignoresSafeArea()
                                            .frame(width: isSmallDevice ? 187 : 237, height: isSmallDevice ? 248 : 298)
                                        Text("Tap to choose Image")
                                            .foregroundColor(.white)
                                            .font(Font.custom("PressStart2P", size: isSmallDevice ? 10 : 12))
                                            .shadow(color: .shadowblack, radius: 0, x: 2, y: 3)
                                    }
                                    .frame(width: isSmallDevice ? 187 : 237, height: isSmallDevice ? 248 : 298)
                                    .shadow(color: .shadowblack, radius: 0, x: 2, y: 3)
                                }

                                if let text = photoManager.texts[date] {
                                    VStack {
                                        ZStack {
                                            Image("textblock")
                                                .resizable()
                                                .ignoresSafeArea()
                                                .frame(width: isSmallDevice ? 246 : 266, height: isSmallDevice ? 187 : 237)
                                            Text(text)
                                                .foregroundColor(.white)
                                                .padding()
                                                .font(Font.custom("PressStart2P", size: 12))
                                                .padding()
                                        }
                                    }
                                    .frame(width: isSmallDevice ? 246 : 266, height: isSmallDevice ? 187 : 237)
                                    .shadow(color: .shadowblack, radius: 0, x: 2, y: 3)
                                } else {
                                    ZStack {
                                        Image("textblock")
                                            .resizable()
                                            .ignoresSafeArea()
                                        Text("Tap to add text")
                                            .padding()
                                            .foregroundColor(.white)
                                            .font(Font.custom("PressStart2P", size: 10))
                                    }
                                    .frame(width: isSmallDevice ? 246 : 266, height: isSmallDevice ? 187 : 237)
                                    .shadow(color: .shadowblack, radius: 0, x: 2, y: 3)
                                }
                            }
                        }
                        .frame(width: isSmallDevice ? 280 : 320, height: isSmallDevice ? 508 : 608)
                    }
                    .frame(width: isSmallDevice ? 280 : 320, height: isSmallDevice ? 508 : 608)
                    .aspectRatio(contentMode: .fill)
                    .navigationBarHidden(true)

                    HStack(spacing: isSmallDevice ? 25 : 25) {
                        Image(imageName(for: yourchoice.ychosenCat))
                            .resizable()
                            .frame(width: isSmallDevice ? 75 : 75, height: isSmallDevice ? 75 : 75)
                            .shadow(color: .shadowblack, radius: 0, x: 2, y: 3)
                        
                        Button(action: {
                            isButtonHidden = true
                            isBackButtonHidden = true
                            DispatchQueue.main.asyncAfter(deadline: .now()) {
                                capturedImage = captureViewAsImage()
                                isButtonHidden = false
                                isBackButtonHidden = false
                                if capturedImage != nil {
                                    showingShareSheet = true
                                }
                            }
                        }) {
                            Image("setbuttoncircle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: isSmallDevice ? 75 : 100, height: isSmallDevice ? 75 : 75)
                        }
                        .opacity(isButtonHidden ? 0 : 1)
                        .sheet(isPresented: $showingShareSheet) {
                            if let capturedImage = capturedImage {
                                ShareSheet(activityItems: [capturedImage])
                            }
                        }
                        Image(imageName(for: partnerschosencat.pchosenCat))
                            .resizable()
                            .frame(width: isSmallDevice ? 75 : 75, height: isSmallDevice ? 75 : 75)
                            .shadow(color: .shadowblack, radius: 0, x: 2, y: 3)
                    }
                    .padding(.top, isSmallDevice ? 5 : 10)
                }
                .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                    if value.startLocation.x < 20 && value.translation.width > 100 {
                        self.mode.wrappedValue.dismiss()
                    }
                }))
                .frame(width: geometry.size.width, height: geometry.size.height)
                .aspectRatio(contentMode: .fill)
                .navigationBarHidden(true)
                .offset(y: isSmallDevice ? -100 : -40)
            }
        }
        .navigationBarHidden(true)
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
            if value.startLocation.x < 20 && value.translation.width > 100 {
                self.mode.wrappedValue.dismiss()
            }
        }))
    }

    private func captureViewAsImage() -> UIImage {
        guard let windowScene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
              let rootView = windowScene.windows.first?.rootViewController?.view else {
            return UIImage()
        }
        
        let renderer = UIGraphicsImageRenderer(bounds: rootView.bounds)
        return renderer.image { ctx in
            rootView.drawHierarchy(in: ctx.format.bounds, afterScreenUpdates: true)
        }
    }

}

struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}


struct PreviewSendView_Previews: PreviewProvider {
    static var previews: some View {
        let photoManager = PhotoManager()
        PreviewSendView(
            date: Date(),
            yourchoice: yourchosencat(),
            username: Username(),
            partnersname: Partnersname(),
            partnerschosencat: partnerschosencat()
        )
        .environmentObject(photoManager)
    }
}
