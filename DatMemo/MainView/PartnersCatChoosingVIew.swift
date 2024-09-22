import SwiftUI



struct PartnersCatChoosingView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var partnerschoice: partnerschosencat

    let background = Image("Background")
    @ScaledMetric(relativeTo: .body) var scaledPadding: CGFloat = 20
    @GestureState private var dragOffset = CGSize.zero

    var body: some View {
        ZStack {
            background
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()

            VStack(alignment: .center) {
                
                Spacer()
                
                CustomBackButton1 {
                                   self.mode.wrappedValue.dismiss()
                               }
                               .padding(.trailing, 320)
                Spacer()

                Button {
                    print("Partner's cat is ArtiomkaCat")
                    partnerschoice.pchosenCat = 1
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Image("artiomkaCatChoosingButton")
                        .resizable()
                        .frame(width: 160, height: 160)
                        .shadow(color: .shadowblack, radius: 0, x: 6, y: 5)
                        .padding(.bottom, scaledPadding * 1.5)
                }

                Button {
                    print("Partner's cat is SashenkaCat")
                    partnerschoice.pchosenCat = 2
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Image("sashenkaCatChoosingButton")
                        .resizable()
                        .frame(width: 160, height: 160)
                        .shadow(color: .shadowblack, radius: 0, x: 6, y: 5)
                        .padding(.bottom, scaledPadding * 1.5)
                }

                Button {
                    print("Partner's cat is DimaCat")
                    partnerschoice.pchosenCat = 3
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Image("dimaCatChoosingButton")
                        .resizable()
                        .frame(width: 160, height: 160)
                        .shadow(color: .shadowblack, radius: 0, x: 6, y: 5)
                }

                Spacer()
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .onAppear { AudioManager.shared.configureAudioSession() }
        .onDisappear { AudioManager.shared.deactivateAudioSession() }
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
            if value.startLocation.x < 20 && value.translation.width > 100 {
                self.mode.wrappedValue.dismiss()
            }
        }))
    }
}

#Preview{
    PartnersCatChoosingView(partnerschoice: partnerschosencat())
}
