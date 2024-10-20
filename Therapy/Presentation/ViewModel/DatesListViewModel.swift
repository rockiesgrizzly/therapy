import SwiftUI

class DatesListViewModel: ObservableObject {
    @Binding var dateTaskToSelect: DateTask?
    let dateTasks: [DateTask]
    
    static let titleText = "My Tasks"
    
    init(dateTaskToSelect: Binding<DateTask?>, dateTasks: [DateTask]) {
        _dateTaskToSelect = dateTaskToSelect
        self.dateTasks = dateTasks
    }
}
