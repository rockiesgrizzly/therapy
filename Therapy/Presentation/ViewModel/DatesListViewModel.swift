import SwiftUI

class DatesListViewModel: ObservableObject {
    @Binding var dateTaskToSelect: DateTask?
    let dateTasks: [DateTask]
    var colorScheme: ColorScheme
    
    let titleText = "My Tasks"
    
    init(dateTaskToSelect: Binding<DateTask?>, dateTasks: [DateTask], colorScheme: ColorScheme) {
        _dateTaskToSelect = dateTaskToSelect
        self.dateTasks = dateTasks
        self.colorScheme = colorScheme
    }
    
    var backgroundColor: Color {
        if colorScheme == .light {
           return Color(red: 253 / 255, green: 249 / 255, blue: 238 / 255)
        }
        return .black
    }
}
