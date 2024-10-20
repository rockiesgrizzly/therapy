
import Foundation

protocol TasksRepositoryProtocol {
    static func taskResponse(service: TasksServiceProtocol.Type) async throws -> TasksResponse
}

/// Implementation of `TasksRepository`
struct TasksRepository: TasksRepositoryProtocol {
    static func taskResponse(service: TasksServiceProtocol.Type = TasksLocalService.self) async throws -> TasksResponse {
        try await service.taskResponse
    }
}
