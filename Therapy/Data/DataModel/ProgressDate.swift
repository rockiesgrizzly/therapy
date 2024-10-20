import Foundation

struct ProgressDate {
    let date: Date
    var completed: Bool
    let breathCount: Int?
    let moodChoices: [String]?
}

// MARK: - TasksResponse.Task Interface

extension ProgressDate {
    static func from(_ task: TasksResponse.Task) -> Self? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let dueDate = task.dueDate,
            let date = dateFormatter.date(from: dueDate) {
            return ProgressDate(date: date, completed: false, breathCount: task.breathCount, moodChoices: task.moodChoices)
        }
        
        return nil
    }
    
    static func from(_ tasks: [TasksResponse.Task]) -> [Self] {
        var result = [ProgressDate]()
        
        for task in tasks {
            guard let progressDate = ProgressDate.from(task) else { continue }
            result.append(progressDate)
        }
        
        return result
    }
}

extension ProgressDate: Equatable {
    
}
