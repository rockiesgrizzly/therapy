import Foundation

struct DateTask: Identifiable, Equatable, Hashable {
    let id = UUID()
    let date: Date
    var completed: Bool
    var enabled: Bool = false
    let breathCount: Int?
    let moodChoices: [String]?
    
    /// Changes with user selection
    var selected: Bool = false
    var currentView = ViewType.datesList
}
