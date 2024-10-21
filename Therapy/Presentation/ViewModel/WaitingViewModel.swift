import SwiftUI

class WaitingViewModel: ObservableObject {
    let titleText = "Waiting for Provider"
    let subtitleText = "When they come online, you'll be redirected to the session automatically."
    
    // MARK: - Color
    
    var viewBackgroundColor: Color {
        Color(red: 215 / 255, green: 240 / 255, blue: 190 / 255)
    }
}
