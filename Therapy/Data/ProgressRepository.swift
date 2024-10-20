
protocol ProgressRepositoryProtocol {
    static var dates: [ProgressDate] { get async throws }
}

struct ProgressRepository {
    static var dates: [ProgressDate] {
        get async throws {
            try await ProgressDataSource.dates()
        }
    }
}
