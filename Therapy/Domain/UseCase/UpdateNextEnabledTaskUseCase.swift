
protocol UpdateNextEnabledTaskUseCaseProtocol {
    static func updateNextEnabledTaskIfNeeded(in dateTasks: [DateTask]) -> [DateTask]
}

struct UpdateNextEnabledTaskUseCase: UpdateNextEnabledTaskUseCaseProtocol {
    static func updateNextEnabledTaskIfNeeded(in dateTasks: [DateTask]) -> [DateTask] {
        var updatedDateTasks = dateTasks
        
        if let index = dateTasks.firstIndex(where: { !$0.enabled && $0.date == updatedDateTasks
            .filter({ !$0.enabled }).min(by: { $0.date < $1.date })?.date }) {
            updatedDateTasks[index].enabled = true
        } else {
            updatedDateTasks[updatedDateTasks.count - 1].enabled = true
        }
        
        return updatedDateTasks
    }
}
