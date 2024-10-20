
protocol ProgressRepositoryProtocol {
    static func dates(dataSource: ProgressDataSourceProtocol.Type) async throws -> [ProgressDate]
}

struct ProgressRepository: ProgressRepositoryProtocol {
    static func dates(dataSource: ProgressDataSourceProtocol.Type = ProgressDataSource.self) async throws -> [ProgressDate] {
        try await dataSource.dates()
    }
}
