import SwiftUI

class SessionViewModel: ObservableObject {
    @Binding var userCompletedSessionTask: Bool
    let titleText = "In Session"
    let buttonText = "Exit"
    
    init(userCompletedSessionTask: Binding<Bool>) {
        _userCompletedSessionTask = userCompletedSessionTask
    }
    
    // MARK: - Color
    
    var viewBackgroundColor: Color {
        Color(red: 215 / 255, green: 240 / 255, blue: 190 / 255)
    }
}
