import SwiftUI

class BreathViewModel: ObservableObject {
    @Binding var userCompletedBreathTask: Bool
    @Binding var userSkippedToSession: Bool
    
    @State var providerIsReady = true
    @Published var currentSecond: Int = 0
    @Published var scale: CGFloat = 1.0
    
    let totalBreathingSeconds: Int
    let title = "Breathe for"
    let providerText = "Provider is in the session"
    let joinText = "Join Now"
    
    var timer: Timer?
    
    init(userCompletedBreathTask: Binding<Bool>, userSkippedToSession: Binding<Bool>, totalBreathingSeconds: Int) {
        _userCompletedBreathTask = userCompletedBreathTask
        _userSkippedToSession = userSkippedToSession
        self.totalBreathingSeconds = totalBreathingSeconds
    }
    
    func respondToOnAppear() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self else { return }
            
            currentSecond += 1
            scale = currentSecond % 2 == 0 ? 1.0 : 0.5 // Toggle scale every second
            
            if currentSecond >= totalBreathingSeconds {
                timer.invalidate()
                userCompletedBreathTask = true
            }
        }
    }
}
