// DayView.swift
// DatMemo
//
// Created by Artiom Gramatin on 28.06.2024.

import SwiftUI
import Foundation

extension Date {
    func formattedWithSuffix() -> String {
        let day = Calendar.current.component(.day, from: self)
        let dayFormatter = NumberFormatter()
        dayFormatter.numberStyle = .ordinal
        let dayString = dayFormatter.string(from: NSNumber(value: day)) ?? "\(day)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let monthString = dateFormatter.string(from: self)
        return "The \(dayString) of \(monthString)"
    }
}

struct DayView: View {
    let date: Date
    let backgroundBlur = Image("backgroundblur")
    
    @GestureState private var dragOffset = CGSize.zero
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var photoManager: PhotoManager
    @ScaledMetric(relativeTo: .body) var scaledsize: CGFloat = 95
    @ObservedObject var yourchoice: yourchosencat
    @ObservedObject var username: Username
    @ObservedObject var partnersname: Partnersname
    @ObservedObject var partnerschosencat: partnerschosencat

    @State private var isNavigationActive = false
    @State private var selectedPhoto: UIImage?
    @State private var inputText: String = ""
    @State private var isImagePickerPresented = false
    @State private var isCameraPickerPresented = false
    @State private var showPhotoSourcePicker = false
    @State private var showTextEditor = false
    @State private var showAlert = false
    @State private var showIncompleteAlert = false
    @State private var showConfirmationAlert = false
    @State private var contentSaved = true
    @State private var missingTextAlert = false
    @State private var missingImageAlert = false
    @State private var textCompleted = false
    @State private var imageCompleted = false

    var onSaveContent: ((Date) -> Void)?

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                let isSmallDevice = geometry.size.height < 667
                ZStack {
                    backgroundBlur
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                    
                    VStack(alignment: .center) {
                        HStack(alignment: .center) {
                            CustomBackButton1 {
                                if !contentSaved && (selectedPhoto != nil || !inputText.isEmpty) {
                                    showConfirmationAlert = true
                                } else {
                                    self.mode.wrappedValue.dismiss()
                                }
                            }
                            .offset(x: isSmallDevice ? 75 : 75)
                            .frame(width: isSmallDevice ? 42 : 42, height: isSmallDevice ? 42 : 42)

                            HStack(alignment: .center) {
                                Heart(username: username, partnersname: partnersname)
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
                                        .font(Font.custom("PressStart2P", fixedSize: 10))
                                        .foregroundColor(.white)
                                        .padding(.bottom, 2)
                                        .padding(.top, -10)
                                    
                                    if let selectedPhoto = photoManager.photos[date] {
                                        ZStack {
                                            Image("textblock")
                                                .resizable()
                                                .ignoresSafeArea()
                                                .frame(width: isSmallDevice ? 217 : 237, height: isSmallDevice ? 248 : 298)
                                                .shadow(color: .shadowblack, radius: 0, x: 2, y: 3)
                                            Image(uiImage: selectedPhoto)
                                                .resizable()
                                                .scaledToFit()
                                                .ignoresSafeArea()
                                                .frame(maxWidth: isSmallDevice ? 208 : 228, maxHeight: isSmallDevice ? 248 : 288)
                                                .aspectRatio(contentMode: .fit)
                                                .onTapGesture {
                                                    showPhotoSourcePicker = true
                                                }
                                        }
                                    } else {
                                        ZStack {
                                            Image("textblock")
                                                .resizable()
                                                .ignoresSafeArea()
                                                .frame(width: isSmallDevice ? 187 : 237, height: isSmallDevice ? 248 : 298)
                                            Button("Tap to choose Image") {
                                                showPhotoSourcePicker = true
                                            }
                                            .foregroundColor(.white)
                                            .font(Font.custom("PressStart2P", size: 10))
                                            .frame(width: isSmallDevice ? 187 : 237, height: isSmallDevice ? 248 : 298)
                                        }
                                        .frame(width: isSmallDevice ? 217 : 237, height: isSmallDevice ? 248 : 298)
                                        .shadow(color: .shadowblack, radius: 0, x: 2, y: 3)
                                    }

                                    if let text = photoManager.texts[date] {
                                        VStack {
                                            ZStack {
                                                Image("textblock")
                                                    .resizable()
                                                    .ignoresSafeArea()
                                                    .frame(width: isSmallDevice ? 246 : 266, height: isSmallDevice ? 187 : 237)
                                                VStack {
                                                    Text(text)
                                                        .foregroundStyle(Color.white)
                                                        .padding()
                                                        .font(Font.custom("PressStart2P", size: 11.4))
                                                        .cornerRadius(8)
                                                        .padding()
                                                        .onTapGesture {
                                                            inputText = text
                                                            showTextEditor = true
                                                        }
                                                }
                                            }
                                            .frame(width: isSmallDevice ? 246 : 266, height: isSmallDevice ? 187 : 237)
                                            .shadow(color: .shadowblack, radius: 0, x: 2, y: 3)
                                        }
                                    } else {
                                        ZStack {
                                            Image("textblock")
                                                .resizable()
                                                .ignoresSafeArea()
                                                .scaledToFit()
                                            Button("Tap to text") {
                                                showTextEditor = true
                                            }
                                            .padding()
                                            .foregroundColor(.white)
                                            .font(Font.custom("PressStart2P", size: 10))
                                        }
                                        .frame(width: isSmallDevice ? 246 : 266, height: isSmallDevice ? 187 : 237)
                                        .shadow(color: .shadowblack, radius: 0, x: 2, y: 3)
                                    }
                                }
                                .actionSheet(isPresented: $showPhotoSourcePicker) {
                                    ActionSheet(title: Text("Select Photo Source"), message: nil, buttons: [
                                        .default(Text("Camera")) {
                                            isCameraPickerPresented = true
                                        },
                                        .default(Text("Photo Library")) {
                                            isImagePickerPresented = true
                                        },
                                        .cancel()
                                    ])
                                }
                                .sheet(isPresented: $isImagePickerPresented) {
                                    ImagePicker(image: $selectedPhoto, sourceType: .photoLibrary, mediaTypes: ["public.image"]) { photo in
                                        if let photo = photo {
                                            photoManager.savePhoto(photo, for: date)
                                            selectedPhoto = photo
                                            contentSaved = false
                                            imageCompleted = true
                                        }
                                    }
                                }
                                .sheet(isPresented: $isCameraPickerPresented) {
                                    ImagePicker(image: $selectedPhoto, sourceType: .camera, mediaTypes: ["public.image"]) { photo in
                                        if let photo = photo {
                                            photoManager.savePhoto(photo, for: date)
                                            selectedPhoto = photo
                                            contentSaved = false
                                            imageCompleted = true
                                        }
                                    }
                                }
                                .sheet(isPresented: $showTextEditor) {
                                    TextEditorView(text: $inputText) { text in
                                        if text.count <= 200 && text.count >= 1 {
                                            photoManager.saveText(text, for: date)
                                            inputText = text
                                            contentSaved = false
                                            showTextEditor = false
                                            textCompleted = true
                                        }
                                    }
                                }
                            }
                            .frame(width: isSmallDevice ? 280 : 320, height: isSmallDevice ? 508 : 608)
                        }
                        Button(action: {
                            if let _ = photoManager.photos[date], let savedText = photoManager.texts[date], !savedText.isEmpty {
                                contentSaved = true
                                onSaveContent?(date)
                                isNavigationActive = true
                                scheduleNotification()
                            } else if photoManager.photos[date] == nil && (inputText.isEmpty || photoManager.texts[date] == nil) {
                                showIncompleteAlert = true
                            } else if photoManager.photos[date] == nil {
                                missingImageAlert = true
                            } else if inputText.isEmpty || textCompleted == false {
                                missingTextAlert = true
                            }
                        }) {
                            Image("sendbutton")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: isSmallDevice ? 230 : 250, height: isSmallDevice ? 55 : 75)
                        }
                        .shadow(color: .shadowblack, radius: 0, x: 2, y: 3)
                        .navigationDestination(isPresented: $isNavigationActive) {
                            PreviewSendView(date: date, yourchoice: yourchoice, username: username, partnersname: partnersname, partnerschosencat: partnerschosencat)
                                .environmentObject(photoManager)
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .aspectRatio(contentMode: .fill)
                .navigationBarHidden(true)
                .offset(y: isSmallDevice ? -175 : -135)
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            state = value.translation
                        }
                        .onEnded { value in
                            if value.translation.width > 100 {
                                if !contentSaved && (selectedPhoto != nil || !inputText.isEmpty) {
                                    showConfirmationAlert = true
                                } else {
                                    self.mode.wrappedValue.dismiss()
                                }
                            }
                        }
                )
                .alert(isPresented: $showConfirmationAlert) {
                    Alert(
                        title: Text("Unsaved Changes"),
                        message: Text("You have unsaved changes. Do you want to discard them and leave?"),
                        primaryButton: .destructive(Text("Discard")) {
                            // Discard changes and dismiss view
                            contentSaved = true
                            self.mode.wrappedValue.dismiss()
                        },
                        secondaryButton: .cancel()
                    )
                }
                .alert(isPresented: $showIncompleteAlert) {
                    Alert(
                        title: Text("Incomplete Content"),
                        message: Text("Please fill in all the content before saving."),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .alert(isPresented: $missingImageAlert) {
                    Alert(
                        title: Text("Missing Image"),
                        message: Text("Please add an image before saving."),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .alert(isPresented: $missingTextAlert) {
                    Alert(
                        title: Text("Missing Text"),
                        message: Text("Please add text before saving."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            .navigationBarBackButtonHidden(true)
        }
        .onAppear {
            if let _ = photoManager.photos[date], let savedText = photoManager.texts[date], !savedText.isEmpty {
                contentSaved = true
            }
        }
        .onChange(of: selectedPhoto) { oldPhoto, newPhoto in
            if oldPhoto != newPhoto {
                contentSaved = false
            }
        }
        .onChange(of: inputText) { oldText, newText in
            if oldText != newText {
                contentSaved = false
            }
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        let date = Date()
        let yourchoice = yourchosencat()
        let username = Username()
        let partnersname = Partnersname()
        let partnerschosencat = partnerschosencat()
        
        return DayView(date: date, yourchoice: yourchoice, username: username, partnersname: partnersname, partnerschosencat: partnerschosencat)
            .environmentObject(PhotoManager())
    }
}
