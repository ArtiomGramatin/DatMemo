import AVFoundation

class AudioManager {
    static let shared = AudioManager()

    private init() {}

    func configureAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [])
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            print("Success configuring")
        } catch {
            print("Error configuring audio session: \(error.localizedDescription)")
        }
    }

    func deactivateAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            if audioSession.isOtherAudioPlaying {
                try audioSession.setActive(false)
            }
        } catch {
            print("Error deactivating audio session: \(error.localizedDescription)")
        }
    }
}
