import SwiftUI

class DateDetailViewModel: ObservableObject {
    var date: String
    @State var enabled: Bool = false
    @State var completed: Bool = false
    var colorScheme: ColorScheme
    
    init(date: String, enabled: Bool, completed: Bool, colorScheme: ColorScheme) {
        self.date = date
        self.enabled = enabled
        self.completed = completed
        self.colorScheme = colorScheme
    }
    
    enum SystemImage: String {
        case checkmark = "checkmark.seal.fill"
        case chevronRight = "chevron.right"
        case lock = "lock"
    }
    
    var systemImage: SystemImage {
        if completed {
            return .checkmark
        } else if enabled {
            return .chevronRight
        }
        return .lock
    }
    
    // MARK: - Color
    var completedColor: Color {
        Color(red: 215 / 255, green: 240 / 255, blue: 190 / 255)
    }
    
    var foregroundColor: Color {
        switch systemImage {
        case .checkmark: 
            return checkmarkColor
        default: 
            if enabled == false {
                return Color.gray
            } else if colorScheme == .light {
                return Color.black
            }
                return Color.white
        }
    }
    
    var checkmarkColor: Color {
        Color(red: 189 / 255, green: 177 / 255, blue: 250 / 255)
    }
    
    var dateTextColor: Color {
        if enabled == false {
            return .gray
        } else if colorScheme == .light {
            return .black
        }
        return .white
    }
    
    var borderColor: Color {
        if enabled == false {
            return .gray
        } else if colorScheme == .light {
            return .black
        }
        return .white
    }
}
