
protocol ProgressDataSourceProtocol {
    static func dates() async throws -> [ProgressDate]
}

struct ProgressDataSource: ProgressDataSourceProtocol {
    static private var storedDates = [ProgressDate]()
    
    // with more time, would persist and sync with retrievedDates
    
    // MARK: - Internal
    
    static func dates() async throws -> [ProgressDate] {
        try await updateIfNeeded()
        return storedDates
    }
    
    // MARK: - Private
    
    static private func updateIfNeeded() async throws {
        guard storedDates.isEmpty else { return }
        var retrievedDates = try await retrievedDates
        retrievedDates.sort { $0.date > $1.date }
        storedDates = retrievedDates
    }
    
    static private func updateProgress(with date: ProgressDate) async throws {
        guard let index = storedDates.firstIndex(of: date) else { throw ProgressDataSourceError.noDateToUpdate }
        storedDates[index].completed = date.completed
    }
    
    private static var retrievedDates: [ProgressDate] {
        get async throws {
            let taskResponse = try await TasksRepository.taskResponse()
            guard let tasks = taskResponse.tasks else { throw ProgressDataSourceError.noTasks }
            return ProgressDate.from(tasks)
        }
    }
}

enum ProgressDataSourceError: Error {
    case noDateToUpdate
    case noTasks
    case retrievalIssue
}
