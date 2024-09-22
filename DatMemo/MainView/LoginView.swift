import SwiftUI
import AVFoundation
import Photos
import Contacts
import UserNotifications
import UIKit



struct LoginView: View {
    let background = Image("Background")
    @ScaledMetric(relativeTo: .body) var scaledPadding: CGFloat = 20
    @ScaledMetric(relativeTo: .body) var scaledframewidth: CGFloat = 160
    @ScaledMetric(relativeTo: .body) var scaledframeheight: CGFloat = 60
    @ScaledMetric(relativeTo: .body) var scaledframeButtonHeight: CGFloat = 100
    @ScaledMetric(relativeTo: .body) var scaledframeButtonWidth: CGFloat = 250
    @ScaledMetric(relativeTo: .body) var scaledframeDefaultSizeOne: CGFloat = 1
    @State var buttonOffset: CGFloat = 0
    @State private var showErrorText = false
    
    @StateObject var yourchoice = yourchosencat()
    @StateObject var partnerschoice = partnerschosencat()
    @ObservedObject var usernameObj = Username()
    @ObservedObject var partnersnameObj = Partnersname()
    
    @State private var showError = false
    @State private var buttonScale: CGFloat = 1.0
    @State private var showNextView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                background
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                
                if showNextView {
                    MainPageView(yourchoice: yourchoice, username: usernameObj, partnersname: partnersnameObj, partnerschosencat: partnerschoice)
                        .transition(.opacity)
                } else {
                    loginContentView
                }
            }
        }
        .onAppear {
            #if !targetEnvironment(simulator)
            PermissionsManager.shared.requestAllPermissions { success, deniedPermissions in
                if success {
                    print("All permissions granted")
                } else {
                    print("Some permissions were denied: \(deniedPermissions)")
                }
            }

            #endif
            if UserDefaults.standard.bool(forKey: "loggedIn") {
                yourchoice.ychosenCat = SettingsManager.shared.getYourChoice()
                partnerschoice.pchosenCat = SettingsManager.shared.getPartnersChoice()
                showNextView = true
            }
        }
    }
    
    private var loginContentView: some View {
        VStack(alignment: .center) {
            HStack {
                Text("Choose your cat")
                    .font(Font.custom("PressStart2P", fixedSize: 15))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: scaledframewidth, height: scaledframeheight)
                    .shadow(color: .shadowblack, radius: 0, x: 6, y: 3)
                Text("Choose your partner's cat")
                    .font(Font.custom("PressStart2P", fixedSize: 15))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: scaledframewidth, height: scaledframeheight)
                    .shadow(color: .shadowblack, radius: 0, x: 6, y: 3)
            }
            .padding(.bottom, scaledPadding)
            .padding(.horizontal, scaledPadding)
            
            HStack(alignment: .center) {
                NavigationLink {
                    YourCatChoosingView(yourchoice: yourchoice).environmentObject(yourchoice)
                } label: {
                    ImageForCatChoice(imageName: imageName(for: yourchoice.ychosenCat))
                }
                .frame(width: scaledframewidth, height: scaledframewidth)
                .shadow(color: .shadowblack, radius: 0, x: 6, y: 3)
                
                NavigationLink {
                    PartnersCatChoosingView(partnerschoice: partnerschoice).environmentObject(partnerschoice)
                } label: {
                    ImageForCatChoice(imageName: imageName(for: partnerschoice.pchosenCat))
                }
                .frame(width: scaledframewidth, height: scaledframewidth)
                .shadow(color: .shadowblack, radius: 0, x: 6, y: 3)
            }
            .padding(.horizontal, scaledPadding)
            
            VStack {
                ZStack {
                    Image("YourChoosingButton")
                        .resizable()
                        .frame(width: scaledframeButtonWidth, height: scaledframeButtonHeight)
                        .shadow(color: .shadowblack, radius: 0, x: 6, y: 3)
                    TextField("Name", text: $usernameObj.username)
                        .frame(width: scaledframeButtonWidth * 0.87, height: scaledframeButtonHeight * 0.2)
                        .font(Font.custom("PressStart2P", fixedSize: 20))
                        .foregroundColor(.brownnr2)
                        .padding(.leading, 10)
                        .padding(.top, scaledframeButtonHeight * 0.53)
                        .disableAutocorrection(true)
                        .onChange(of: usernameObj.username) { oldValue, newValue in
                            if usernameObj.username.count > 9 {
                                usernameObj.username = String(usernameObj.username.prefix(9))
                            }
                        }
                }
                .padding(.top, scaledPadding)
                
                ZStack {
                    Image("PartnersChoosingButton")
                        .resizable()
                        .frame(width: scaledframeButtonWidth, height: scaledframeButtonHeight)
                        .shadow(color: .shadowblack, radius: 0, x: 6, y: 3)
                    TextField("Name", text: $partnersnameObj.partnersname)
                        .frame(width: scaledframeButtonWidth * 0.87, height: scaledframeButtonHeight * 0.2)
                        .font(Font.custom("PressStart2P", fixedSize: 20))
                        .foregroundColor(.brownnr2)
                        .padding(.leading, 10)
                        .padding(.top, scaledframeButtonHeight * 0.53)
                        .disableAutocorrection(true)
                        .onChange(of: partnersnameObj.partnersname) { oldValue, newValue in
                            if partnersnameObj.partnersname.count > 9 {
                                partnersnameObj.partnersname = String(partnersnameObj.partnersname.prefix(9))
                            }
                        }
                }
                .padding(.top, scaledPadding)
                
                Button(action: {
                    if usernameObj.username.isEmpty || partnersnameObj.partnersname.isEmpty || yourchoice.ychosenCat == 0 || partnerschoice.pchosenCat == 0 {
                        showError = true
                        withAnimation(Animation.easeInOut(duration: 0.1).repeatCount(3, autoreverses: true)) {
                            buttonOffset = 5
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            buttonOffset = 0
                        }
                    } else {
                        showError = false
                        
                        SettingsManager.shared.saveUsername(usernameObj.username)
                        SettingsManager.shared.savePartnersname(partnersnameObj.partnersname)
                        SettingsManager.shared.saveYourChoice(yourchoice.ychosenCat)
                        SettingsManager.shared.savePartnersChoice(partnerschoice.pchosenCat)
                        
                        UserDefaults.standard.set(true, forKey: "loggedIn")
                        
                        showNextView = true
                    }
                }) {
                    Image("SetButton")
                        .resizable()
                        .shadow(color: .shadowblack, radius: 0, x: 6, y: 3)
                        .offset(x: buttonOffset)
                }
                .frame(width: scaledframeButtonWidth, height: scaledframeButtonHeight * 0.75)
                .padding(.top, scaledPadding)
                
                Text("You need to fill all the fields and choose cats")
                    .font(Font.custom("PressStart2P", fixedSize: 8))
                    .foregroundColor(.white)
                    .frame(width: 200, height: 20, alignment: .center)
                    .padding(.top, scaledPadding * 0.5)
                    .opacity(showError ? 1 : 0)
            }
        }
        .onAppear { AudioManager.shared.configureAudioSession() }
        .onDisappear { AudioManager.shared.deactivateAudioSession() }
    }
    
    private func imageName(for catChoice: Int8) -> String {
        switch catChoice {
        case 1: return "artiomkaCatChoosingButton"
        case 2: return "sashenkaCatChoosingButton"
        case 3: return "dimaCatChoosingButton"
        default: return "ChooseButtonCats"
        }
    }
}

#Preview{
    LoginView()
}
