import SwiftUI

class Validation: ObservableObject {
    @ObservedObject var username: Username
    @ObservedObject var partnersname: Partnersname
    @ObservedObject var yourchoice: yourchosencat
    @ObservedObject var partnerschoice: partnerschosencat
    
    @Published var isFormValid: Bool = false
    
    init(username: Username, partnersname: Partnersname, yourchoice: yourchosencat, partnerschoice: partnerschosencat) {
        self.username = username
        self.partnersname = partnersname
        self.yourchoice = yourchoice
        self.partnerschoice = partnerschoice
        
        self.validateForm()
        
        self.username.objectWillChange.sink { [weak self] in
            self?.validateForm()
        }.store(in: &cancellables)
        
        self.partnersname.objectWillChange.sink { [weak self] in
            self?.validateForm()
        }.store(in: &cancellables)
        
        self.yourchoice.objectWillChange.sink { [weak self] in
            self?.validateForm()
        }.store(in: &cancellables)
        
        self.partnerschoice.objectWillChange.sink { [weak self] in
            self?.validateForm()
        }.store(in: &cancellables)
    }
    
    private func validateForm() {
        isFormValid = !username.username.isEmpty && !partnersname.partnersname.isEmpty && yourchoice.ychosenCat != 0 && partnerschoice.pchosenCat != 0
    }
    
    private var cancellables = Set<AnyCancellable>()
}

