//SplashScreen
//
//
//
import SwiftUI

struct SplashScreen: View {
    @State private var isActive: Bool = false
    @State private var shouldNavigateToMainPage: Bool = false
    
    var body: some View {
        ZStack {
            if self.isActive {
                if self.shouldNavigateToMainPage {
                    MainPageView(
                        yourchoice: yourchosencat(),
                        username: Username(),
                        partnersname: Partnersname(),
                        partnerschosencat: partnerschosencat()
                    )
                } else {
                    LoginView()
                }
            } else {
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                }
            }
        }
        .onAppear {
            checkUserLoginStatus()
        }
    }
    
    private func checkUserLoginStatus() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let username = UserDefaults.standard.string(forKey: "username")
            let partnersname = UserDefaults.standard.string(forKey: "partnersname")
            let ychosenCat = UserDefaults.standard.value(forKey: "ychosenCat") as? Int
            let pchosenCat = UserDefaults.standard.value(forKey: "pchosenCat") as? Int
            
            if username != nil && partnersname != nil && ychosenCat != nil && pchosenCat != nil {
                shouldNavigateToMainPage = true
            } else {
                shouldNavigateToMainPage = false
            }
            withAnimation {
                self.isActive = true
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
