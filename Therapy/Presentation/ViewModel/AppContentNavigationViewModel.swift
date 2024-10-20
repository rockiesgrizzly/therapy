import Foundation

@MainActor
class AppContentNavigationViewModel: ObservableObject {
    /// Main tasks parameter
    @Published var dateTasks = [DateTask]()
    
    /// Dictates which child view should be shown
    @Published var currentView: ViewType = .datesList {
        didSet {
            if currentView == .datesList {
                resetCurrentDateTask()
            }
        }
    }
    
    @Published var dateTaskToSelect: DateTask? {
        didSet {
            guard let dateTaskToSelect else { return }
            try? selectDateTask(dateTaskToSelect)
            currentView = GetNextViewTypeUseCase.result(after: .datesList)
        }
    }
    
    @Published var userCompletedBreathTask: Bool = false {
        didSet {
            currentView = GetNextViewTypeUseCase.result(after: .breath)
        }
    }
    
    @Published var userJoinedFromBreathTask: Bool = false {
        didSet {
            currentView = GetNextViewTypeUseCase.result(after:  .waiting)
        }
    }
    
    @Published var userCompletedWaitingTask: Bool = false {
        didSet {
            currentView = GetNextViewTypeUseCase.result(after: .waiting)
        }
    }
    
    @Published var userCompletedSessionTask: Bool = false {
        didSet {
            userCompletedFinalTask() // TODO: shortcut for time, would add use case instead
        }
    }
    
    @Published var userCompletedMoodTask: Bool = false {
        didSet {
            currentView = GetNextViewTypeUseCase.result(after: .datesList)
        }
    }
    
    var currentDateTask: DateTask? { dateTasks.first(where: \.selected) }
    
    // MARK: - Lifecycle
    init() { }
    
    // MARK: - Internal
    func refreshForViewAppearance() async {
        guard let result = try? await GetDatesUseCase.result else { return }
        
        switch result {
        case .success(let dateTasks): 
            self.dateTasks = UpdateNextEnabledTaskUseCase.updateNextEnabledTaskIfNeeded(in: dateTasks)
        case .failure(let error): assertionFailure(error.localizedDescription)
        }
    }
    
    func selectDateTask(_ dateTask: DateTask) throws {
        guard let task = dateTasks.enumerated().first(where: { $0.element == dateTask }) else { throw AppContentNavigationViewModelError.noTaskFound }
        dateTasks[task.offset].selected = true
    }
    
    var currentDateTaskBreathCount: Float { currentDateTask?.breathCount ?? 9 }
    var currentDateTaskMoods: [String] { currentDateTask?.moodChoices ?? [String]() }
    
    // MARK: - Private
    
    private func refreshCurrentView(for currentViewType: ViewType) {
        currentView = GetNextViewTypeUseCase.result(after: currentViewType)
        dateTasks = UpdateNextEnabledTaskUseCase.updateNextEnabledTaskIfNeeded(in: dateTasks)
    }

    
    private func userCompletedFinalTask() {
        completeCurrentDateTask()
        dateTasks = UpdateNextEnabledTaskUseCase.updateNextEnabledTaskIfNeeded(in: dateTasks)
        currentView = .datesList
    }
    
    private func completeCurrentDateTask() {
        for (index, dateTask) in dateTasks.enumerated() {
            if dateTask.selected {
                dateTasks[index].completed = true
            }
        }
    }
    
    private func resetCurrentDateTask() {
        for (index, dateTask) in dateTasks.enumerated() {
            if dateTask.selected {
                dateTasks[index].selected = false
            }
        }
    }
}

enum AppContentNavigationViewModelError: Error {
    case noTaskFound
}
