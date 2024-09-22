import SwiftUI

struct CustomBackButton1: View {
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

struct settingsview: View {
    private func imageName(for catChoice: Int8) -> String {
        switch catChoice {
        case 1: return "artiomkaCatChoosingButton"
        case 2: return "sashenkaCatChoosingButton"
        case 3: return "dimaCatChoosingButton"
        default: return "ChooseButtonCats"
        }
    }

    @ObservedObject var username: Username
    @ObservedObject var partnersname: Partnersname
    @ObservedObject var yourchoice: yourchosencat
    @ObservedObject var partnerschosencat: partnerschosencat
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {
        GeometryReader { geometry in
            let isSmallDevice = geometry.size.height < 667
            ZStack {
                Color("Color2")
                    .ignoresSafeArea()
                VStack(alignment: .center) {
                    CustomBackButton1 {
                        self.mode.wrappedValue.dismiss()
                    }
                    .padding(.trailing, isSmallDevice ? 300 : 320)
                    Form {
                        Section(header: Text("Your Profile")) {
                            TextField("Username", text: $username.username)
                                .onChange(of: username.username) { oldValue, newValue in
                                    SettingsManager.shared.saveUsername(newValue)
                                }
                            NavigationLink {
                                YourCatChoosingView(yourchoice: yourchoice).environmentObject(yourchoice)
                            } label: {
                                ImageForCatChoice(imageName: imageName(for: yourchoice.ychosenCat))
                            }
                            .frame(width: isSmallDevice ? 150 : 170, height: isSmallDevice ? 140 : 160)
                            .shadow(color: .shadowblack, radius: 0, x: 6, y: 3)
                            .padding()
                            .onChange(of: yourchoice.ychosenCat) { oldValue, newValue in
                                SettingsManager.shared.saveYourChoice(newValue)
                            }
                        }
                        .listRowBackground(Color("Color1"))
                        Section(header: Text("Partner's Profile")) {
                            TextField("Partner's Name", text: $partnersname.partnersname)
                                .onChange(of: partnersname.partnersname) { oldValue, newValue in
                                    SettingsManager.shared.savePartnersname(newValue)
                                }
                            NavigationLink {
                                PartnersCatChoosingView(partnerschoice: partnerschosencat).environmentObject(partnerschosencat)
                            } label: {
                                ImageForCatChoice(imageName: imageName(for: partnerschosencat.pchosenCat))
                            }
                            .frame(width: isSmallDevice ? 150 : 170, height: isSmallDevice ? 140 : 160)
                            .shadow(color: .shadowblack, radius: 0, x: 6, y: 3)
                            .padding()
                            .onChange(of: partnerschosencat.pchosenCat) { oldValue, newValue in
                                SettingsManager.shared.savePartnersChoice(newValue)
                            }
                        }
                        .listRowBackground(Color("Color1"))
                    }
                    .font(Font.custom("PressStart2P", fixedSize: isSmallDevice ? 10 : 14))
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationBarHidden(true)
            .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                if value.startLocation.x < 20 && value.translation.width > 100 {
                    self.mode.wrappedValue.dismiss()
                }
            }))
        }
        .onAppear {
            username.username = SettingsManager.shared.getUsername()
            partnersname.partnersname = SettingsManager.shared.getPartnersname()
            yourchoice.ychosenCat = SettingsManager.shared.getYourChoice()
            partnerschosencat.pchosenCat = SettingsManager.shared.getPartnersChoice()
        }
    }
}

#Preview {
    settingsview(username: Username(), partnersname: Partnersname(), yourchoice: yourchosencat(), partnerschosencat: partnerschosencat())
}
