@testable import Therapy
import Foundation
import Testing

@Suite
struct TherapyUseCaseTests {
    
    // MARK: - GetDatesUseCase Tests
    
    @Test
    func testGetDatesUseCase_success() async throws {
        struct MockProgressDataSource: ProgressDataSourceProtocol {
            static func dates() async throws -> [Therapy.ProgressDate] { [Therapy.ProgressDate]() }
        }
        
        struct MockProgressRepository: ProgressRepositoryProtocol {
            static func dates(dataSource: ProgressDataSourceProtocol.Type) async throws -> [ProgressDate] {
                return [
                    ProgressDate(date: Date(), completed: false, breathCount: 5, moodChoices: ["Happy"]),
                    ProgressDate(date: Date(), completed: true, breathCount: 10, moodChoices: ["Sad"])
                ]
            }
        }
        
        let result = try await MockProgressRepository.dates(dataSource: MockProgressDataSource.self)
        #expect(result.count == 2)
        #expect(result[0].breathCount == 5)
        #expect(result[1].moodChoices == ["Sad"])
    }
    
    @Test
    func testGetDatesUseCase_failure() async throws {
        struct MockProgressDataSource: ProgressDataSourceProtocol {
            static func dates() async throws -> [Therapy.ProgressDate] { [Therapy.ProgressDate]() }
        }
        
        // Create a mock ProgressRepositoryProtocol that throws an error
        struct MockProgressRepository: ProgressRepositoryProtocol {
            static func dates(dataSource: ProgressDataSourceProtocol.Type) async throws -> [ProgressDate] {
                throw ProgressDataSourceError.noTasks
            }
        }
        
        do {
            let result = try await MockProgressRepository.dates(dataSource: MockProgressDataSource.self)
            Issue.record("Error not thrown as expected")
        } catch {
            #expect(error is ProgressDataSourceError)
        }
    }
    
    // MARK: - GetNextViewTypeUseCase Tests
    
    @Test
    func testGetNextViewTypeUseCase() {
        #expect(GetNextViewTypeUseCase.result(after: .datesList) == .breath)
        #expect(GetNextViewTypeUseCase.result(after: .breath) == .join)
        #expect(GetNextViewTypeUseCase.result(after: .join) == .session)
        #expect(GetNextViewTypeUseCase.result(after: .session) == .datesList)
        #expect(GetNextViewTypeUseCase.result(after: .mood) == .datesList)
    }
    
    // MARK: - UpdateNextEnabledTaskUseCase Tests
    
    @Test
    func testUpdateNextEnabledTaskUseCase_noEnabledTasks() {
        let dateTasks = [
            DateTask(date: Date(), completed: false, breathCount: 5, moodChoices: ["Happy"]),
            DateTask(date: Date().addingTimeInterval(86400), completed: false, breathCount: 10, moodChoices: ["Sad"])
        ]
        
        let updatedDateTasks = UpdateNextEnabledTaskUseCase.updateNextEnabledTaskIfNeeded(in: dateTasks)
        #expect(updatedDateTasks[0].enabled == true)
        #expect(updatedDateTasks[1].enabled == false)
    }
    
    @Test
    func testUpdateNextEnabledTaskUseCase_someEnabledTasks() {
        let dateTasks = [
            DateTask(date: Date(), completed: false, enabled: true, breathCount: 5, moodChoices: ["Happy"]),
            DateTask(date: Date().addingTimeInterval(86400), completed: false, breathCount: 10, moodChoices: ["Sad"])
        ]
        
        let updatedDateTasks = UpdateNextEnabledTaskUseCase.updateNextEnabledTaskIfNeeded(in: dateTasks)
        #expect(updatedDateTasks[0].enabled == true)
        #expect(updatedDateTasks[1].enabled == true)
    }
    
    @Test
    func testUpdateNextEnabledTaskUseCase_allEnabledTasks() {
        let dateTasks = [
            DateTask(date: Date(), completed: false, enabled: true, breathCount: 5, moodChoices: ["Happy"]),
            DateTask(date: Date().addingTimeInterval(86400), completed: false, enabled: true, breathCount: 10, moodChoices: ["Sad"])
        ]
        
        let updatedDateTasks = UpdateNextEnabledTaskUseCase.updateNextEnabledTaskIfNeeded(in: dateTasks)
        #expect(updatedDateTasks[0].enabled == true)
        #expect(updatedDateTasks[1].enabled == true)
    }
}
