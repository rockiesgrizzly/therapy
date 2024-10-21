import SwiftUICore

protocol GetNextViewTypeUseCaseProtocol {
    static func result(after viewType: ViewType) -> ViewType
}

struct GetNextViewTypeUseCase: GetNextViewTypeUseCaseProtocol {
    static var providerIsReady: Bool = false
    
    static func result(after viewType: ViewType) -> ViewType {
        switch viewType {
        case .datesList: .breath
        case .breath: !providerIsReady ? .waiting : .join
        case .waiting: .join
        case .join: .session
        case .session: .datesList
        case .mood: .datesList
        }
    }
}
