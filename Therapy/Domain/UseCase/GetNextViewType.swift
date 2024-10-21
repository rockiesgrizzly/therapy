
protocol GetNextViewTypeUseCaseProtocol {
    static func result(after viewType: ViewType) -> ViewType
}

struct GetNextViewTypeUseCase: GetNextViewTypeUseCaseProtocol {
    static func result(after viewType: ViewType) -> ViewType {
        switch viewType {
        case .datesList: .breath
        case .breath: .join
        case .join: .session
        case .session: .datesList
        case .mood: .datesList
        }
    }
}
