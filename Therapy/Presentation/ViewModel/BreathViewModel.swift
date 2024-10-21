import SwiftUI

class BreathViewModel: ObservableObject {
    @Binding var userCompletedBreathTask: Bool
    @Binding var userSkippedToSession: Bool
    @Binding var showJoinButton: Bool
    
    @Published var currentSecond: Int = 0
    @Published var scale: CGFloat = 1.0
    var colorScheme: ColorScheme
    
    let totalBreathingSeconds: Float
    let title = "Breathe for"
    let providerText = "Provider is in the session"
    let joinText = "Join Now"
    
    var timer: Timer?
    
    init(userCompletedBreathTask: Binding<Bool>, userSkippedToSession: Binding<Bool>, showJoinButton: Binding<Bool>,
         totalBreathingSeconds: Float, colorScheme: ColorScheme) {
        _userCompletedBreathTask = userCompletedBreathTask
        _userSkippedToSession = userSkippedToSession
        _showJoinButton = showJoinButton
        self.totalBreathingSeconds = totalBreathingSeconds
        self.colorScheme = colorScheme
    }
    
    func respondToOnAppear() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self else { return }
            
            currentSecond += 1
            scale = currentSecond % 2 == 0 ? 1.0 : 0.5 // Toggle scale every second
            
            if currentSecond >= Int(totalBreathingSeconds) {
                timer.invalidate()
                userCompletedBreathTask = true
            }
        }
    }
    
    
    var backgroundColor: Color {
        if colorScheme == .light {
           return Color(red: 253 / 255, green: 249 / 255, blue: 238 / 255)
        }
        return .black
    }
}
