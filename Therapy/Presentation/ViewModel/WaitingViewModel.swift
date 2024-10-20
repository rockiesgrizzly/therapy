import SwiftUI

class WaitingViewModel: ObservableObject {
    @Binding var userCompletedWaiting: Bool
    let titleText = "Provider is in the session"
    let buttonText = "Join Now"
    
    init(userCompletedWaiting: Binding<Bool>) {
        _userCompletedWaiting = userCompletedWaiting
    }
    
    // MARK: - Colors
    
    var buttonBackgroundColor: Color {
        Color(red: 215 / 255, green: 240 / 255, blue: 190 / 255)
    }
    
    var viewBackgroundColor: Color {
        Color(red: 189 / 255, green: 177 / 255, blue: 250 / 255)
    }
}
