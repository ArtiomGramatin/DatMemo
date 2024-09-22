//
//  PreviewContentView.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 09.07.2024.
//

import SwiftUI
import AVKit

struct PreviewContentView: View {
    let date: Date
    @EnvironmentObject var photoManager: PhotoManager
    @ObservedObject var yourchoice: yourchosencat
    @ObservedObject var username: Username
    @ObservedObject var partnersname: Partnersname
    @ObservedObject var partnerschosencat: partnerschosencat

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
                            .padding(sides: [.left], value: 95 * (isSmallDevice ? 0.08 : 0.095))
                            .font(Font.custom("PressStart2P", fixedSize: (isSmallDevice ? 7.6 : 7.6)))
                            .foregroundColor(Color.brownnr2)
                            .frame(width: 95 * (isSmallDevice ? 1.064 : 1.064), height: 95 * (isSmallDevice ? 0.076 : 0.076), alignment: .trailing)
                            .shadow(color: .shadowblack, radius: 0, x: 1, y: 1)

                        Image("heart")
                            .resizable()
                            .frame(width: 95 * (isSmallDevice ? 0.46 : 0.6), height: 95 * (isSmallDevice ? 0.4 : 0.56), alignment: .center)
                            .shadow(color: .shadowblack, radius: 0, x: 2, y: 3)

                        Text(partnersname.partnersname)
                            .multilineTextAlignment(.leading)
                            .padding(sides: [.left], value: 95 * (isSmallDevice ? 0.08 : 0.095))
                            .font(Font.custom("PressStart2P", fixedSize: (isSmallDevice ? 7.6 : 7.6)))
                            .foregroundColor(Color.brownnr2)
                            .frame(width: 95 * (isSmallDevice ? 1.064 : 1.064), height: 95 * (isSmallDevice ? 0.076 : 0.076), alignment: .leading)
                            .shadow(color: .shadowblack, radius: 0, x: 1, y: 1)
                    }
                    .frame(width: 95 * 2.926, height: 95 * 0.56, alignment: .center)
                    .padding(.bottom, isSmallDevice ? 10 : 10)
                    .padding(.top, isSmallDevice ? -10 : -45)
                    VStack(alignment: .center) {
                        ZStack {
                            Image("backfordayview")
                                .resizable()
                                .ignoresSafeArea()
                            VStack {
                                Text(date.formattedWithSuffix())
                                    .font(Font.custom("PressStart2P", fixedSize: 10))
                                    .foregroundColor(.white)
                                    .padding(.bottom, 2)
                                    .padding(.top, -10)
                                if let selectedPhoto = photoManager.photos[date] {
                                    ZStack {
                                        Image("textblock")
                                            .resizable()
                                            .ignoresSafeArea()
                                            .frame(width: isSmallDevice ? 237 : 237, height: isSmallDevice ? 298 : 298)
                                        Image(uiImage: selectedPhoto)
                                            .resizable()
                                            .scaledToFit()
                                            .ignoresSafeArea()
                                            .frame(maxWidth: isSmallDevice ? 228 : 228, maxHeight: isSmallDevice ? 288 : 288)
                                            .aspectRatio(contentMode: .fit)
                                    }
                                } else if let selectedVideo = photoManager.videos[date] {
                                    ZStack {
                                        Image("textblock")
                                            .resizable()
                                            .ignoresSafeArea()
                                            .frame(width: isSmallDevice ? 237 : 237, height: isSmallDevice ? 298 : 298)
                                        VideoPlayer(player: AVPlayer(url: selectedVideo))
                                            .frame(maxWidth: isSmallDevice ? 228 : 228, maxHeight: isSmallDevice ? 288 : 288)
                                            .aspectRatio(contentMode: .fit)
                                    }
                                } else {
                                    ZStack {
                                        Image("textblock")
                                            .resizable()
                                            .ignoresSafeArea()
                                            .frame(width: isSmallDevice ? 237 : 237, height: isSmallDevice ? 298 : 298)
                                        Text("No media selected")
                                            .foregroundColor(.white)
                                            .font(Font.custom("PressStart2P", size: 10))
                                    }
                                    .frame(width: isSmallDevice ? 237 : 237, height: isSmallDevice ? 298 : 298)
                                }

                                if let text = photoManager.texts[date] {
                                    VStack {
                                        ZStack {
                                            Image("textblock")
                                                .resizable()
                                                .ignoresSafeArea()
                                                .frame(width: isSmallDevice ? 266 : 266, height: isSmallDevice ? 237 : 237)
                                            VStack {
                                                Text(text)
                                                    .foregroundStyle(Color.white)
                                                    .padding()
                                                    .font(Font.custom("PressStart2P", size: 11.4))
                                                    .cornerRadius(8)
                                                    .padding()
                                            }
                                        }
                                        .frame(width: isSmallDevice ? 266 : 266, height: isSmallDevice ? 237 : 237)
                                    }
                                } else {
                                    ZStack {
                                        Image("textblock")
                                            .resizable()
                                            .ignoresSafeArea()
                                            .scaledToFit()
                                        Text("No text provided")
                                            .padding()
                                            .foregroundColor(.white)
                                            .font(Font.custom("PressStart2P", size: 10))
                                    }
                                    .frame(width: isSmallDevice ? 266 : 266, height: isSmallDevice ? 237 : 237)
                                }
                            }
                        }
                        .frame(width: isSmallDevice ? 300 : 300, height: isSmallDevice ? 608 : 608)
                    }
                }
                .frame(width: geometry.size.width)
                .aspectRatio(contentMode: .fill)
                .navigationBarHidden(true)
            }
        }
    }
}
