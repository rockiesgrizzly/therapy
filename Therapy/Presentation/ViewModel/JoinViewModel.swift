import SwiftUI

class JoinViewModel: ObservableObject {
    @Binding var showJoinButton: Bool
    @Binding var userCompletedJoin: Bool
    let titleText = "Provider is in the session"
    let buttonText = "Join Now"
    
    init(userCompletedJoin: Binding<Bool>, userJoinButton: Binding<Bool>) {
        _userCompletedJoin = userCompletedJoin
        _showJoinButton = userJoinButton
    }
    
    // MARK: - Colors
    
    var buttonBackgroundColor: Color {
        Color(red: 215 / 255, green: 240 / 255, blue: 190 / 255)
    }
    
    var viewBackgroundColor: Color {
        Color(red: 189 / 255, green: 177 / 255, blue: 250 / 255)
    }
}
