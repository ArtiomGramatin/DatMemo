//
//  CaptjureView.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 10.07.2024.
//
import SwiftUI
import AVKit

struct CaptureView: View {
    let date: Date
    @ObservedObject var yourchoice: yourchosencat
    @ObservedObject var username: Username
    @ObservedObject var partnersname: Partnersname
    @ObservedObject var partnerschosencat: partnerschosencat
    @EnvironmentObject var photoManager: PhotoManager

    var body: some View {
        GeometryReader { geometry in
            let isSmallDevice = geometry.size.height < 667
            ZStack {
                Image("backgroundblur")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()

                VStack {
                    HStack {
                        Text(username.username)
                            .padding(.leading, isSmallDevice ? 24 : 32)
                            .font(Font.custom("PressStart2P", size: 16))
                            .foregroundColor(Color.brownnr2)
                            .frame(width: 144, height: 22, alignment: .trailing)
                            .shadow(color: .shadowblack, radius: 0, x: 1, y: 1)

                        Image("heart")
                            .resizable()
                            .frame(width: 64, height: 56, alignment: .center)
                            .shadow(color: .shadowblack, radius: 0, x: 2, y: 3)

                        Text(partnersname.partnersname)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, isSmallDevice ? 24 : 32)
                            .font(Font.custom("PressStart2P", size: 16))
                            .foregroundColor(Color.brownnr2)
                            .frame(width: 144, height: 22, alignment: .leading)
                            .shadow(color: .shadowblack, radius: 0, x: 1, y: 1)
                    }
                    .frame(width: 432, height: 56, alignment: .center)
                    .padding(.bottom, 10)

                    VStack(alignment: .center) {
                        ZStack {
                            Image("backfordayview")
                                .resizable()
                                .ignoresSafeArea()

                            VStack {
                                Text(date.formattedWithSuffix())
                                    .font(Font.custom("PressStart2P", size: 10))
                                    .foregroundColor(.white)
                                    .padding(.bottom, 2)
                                    .padding(.top, -10)

                                if let selectedPhoto = photoManager.photos[date] {
                                    ZStack {
                                        Image("textblock")
                                            .resizable()
                                            .ignoresSafeArea()
                                            .frame(width: 237, height: 298)
                                        Image(uiImage: selectedPhoto)
                                            .resizable()
                                            .scaledToFit()
                                            .ignoresSafeArea()
                                            .frame(maxWidth: 228, maxHeight: 288)
                                            .aspectRatio(contentMode: .fit)
                                    }
                                } else if let selectedVideo = photoManager.videos[date] {
                                    ZStack {
                                        Image("textblock")
                                            .resizable()
                                            .ignoresSafeArea()
                                            .frame(width: 237, height: 298)
                                        VideoPlayer(player: AVPlayer(url: selectedVideo))
                                            .frame(maxWidth: 228, maxHeight: 288)
                                            .aspectRatio(contentMode: .fit)
                                    }
                                } else {
                                    ZStack {
                                        Image("textblock")
                                            .resizable()
                                            .ignoresSafeArea()
                                            .frame(width: 237, height: 298)
                                        Text("Tap to choose Image or video")
                                            .foregroundColor(.white)
                                            .font(Font.custom("PressStart2P", size: 10))
                                    }
                                    .frame(width: 237, height: 298)
                                }

                                if let text = photoManager.texts[date] {
                                    VStack {
                                        ZStack {
                                            Image("textblock")
                                                .resizable()
                                                .ignoresSafeArea()
                                                .frame(width: 266, height: 237)
                                            Text(text)
                                                .foregroundColor(.white)
                                                .padding()
                                                .font(Font.custom("PressStart2P", size: 11.4))
                                                .cornerRadius(8)
                                                .padding()
                                        }
                                    }
                                    .frame(width: 266, height: 237)
                                } else {
                                    ZStack {
                                        Image("textblock")
                                            .resizable()
                                            .ignoresSafeArea()
                                        Text("Tap to text")
                                            .padding()
                                            .foregroundColor(.white)
                                            .font(Font.custom("PressStart2P", size: 10))
                                    }
                                    .frame(width: 266, height: 237)
                                }
                            }
                        }
                        .frame(width: isSmallDevice ? 285 : 304, height: 608)
                    }
                    .frame(width: isSmallDevice ? 285 : 304)
                    .aspectRatio(contentMode: .fill)
                    .navigationBarHidden(true)
                    
                    HStack {
                        Image(yourchoice.catImageName)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()

                        Image(partnerschosencat.catImageName)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct CaptureView_Previews: PreviewProvider {
    static var previews: some View {
        let photoManager = PhotoManager()
        CaptureView(
            date: Date(),
            yourchoice: yourchosencat(),
            username: Username(),
            partnersname: Partnersname(),
            partnerschosencat: partnerschosencat()
        )
        .environmentObject(photoManager)
    }
}
