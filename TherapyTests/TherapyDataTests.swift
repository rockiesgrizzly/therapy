
@testable import Therapy
import Foundation
import Testing

struct TherapyDataTests {
    @Test
    func tasksParseSuccess() async throws {
        let response = try await TasksRepository.taskResponse()
        guard let tasks = response.tasks else { Issue.record("Response was nil"); return }
        
        #expect(tasks.count > 0)
        
        for task in tasks {
            testResponse(task)
        }
    }
    
    func testResponse(_ response: TasksResponse.Task) {
        #expect(response.breathCount != nil)
        #expect(response.moodChoices != nil)
        #expect(response.dueDate != nil)
    }
    
    @Test
    func testFromTaskValidDueDate() {
        let task = TasksResponse.Task(breathCount: 5, moodChoices: ["Happy"], dueDate: "2024-10-20")
        let expectedDate = Calendar.current.date(from: DateComponents(year: 2024, month: 10, day: 20))!
        let expectedProgressDate = ProgressDate(date: expectedDate, completed: false, breathCount: 5, moodChoices: ["Happy"])
        
        let progressDate = ProgressDate.from(task)
        
        #expect(progressDate == expectedProgressDate)
    }
    
    @Test
    func testFromTaskInvalidDueDate() {
        let task = TasksResponse.Task(breathCount: 5, moodChoices: ["Happy"], dueDate: "invalid date")
        
        let progressDate = ProgressDate.from(task)
        
        #expect(progressDate == nil)
    }
    
    @Test
    func testFromTaskNilDueDate() {
        let task = TasksResponse.Task(breathCount: 5, moodChoices: ["Happy"], dueDate: nil)
        
        let progressDate = ProgressDate.from(task)
        
        #expect(progressDate == nil)
    }
    
    @Test
    func testFromTasksValidTasks() {
        let task1 = TasksResponse.Task(breathCount: 5, moodChoices: ["Happy"], dueDate: "2024-10-20")
        let task2 = TasksResponse.Task(breathCount: 10, moodChoices: ["Sad"], dueDate: "2024-10-21")
        let tasks = [task1, task2]
        
        let expectedDate1 = Calendar.current.date(from: DateComponents(year: 2024, month: 10, day: 20))!
        let expectedDate2 = Calendar.current.date(from: DateComponents(year: 2024, month: 10, day: 21))!
        let expectedProgressDate1 = ProgressDate(date: expectedDate1, completed: false, breathCount: 5, moodChoices: ["Happy"])
        let expectedProgressDate2 = ProgressDate(date: expectedDate2, completed: false, breathCount: 10, moodChoices: ["Sad"])
        
        let progressDates = ProgressDate.from(tasks)
        
        #expect(progressDates.count == 2)
        #expect(progressDates[0] == expectedProgressDate1)
        #expect(progressDates[1] == expectedProgressDate2)
    }
    
    @Test
    func testFromTasksInvalidTasks() {
        let task1 = TasksResponse.Task(breathCount: 5, moodChoices: ["Happy"], dueDate: "invalid date")
        let task2 = TasksResponse.Task(breathCount: 10, moodChoices: ["Sad"], dueDate: "2024-10-21")
        let tasks = [task1, task2]
        
        let expectedDate2 = Calendar.current.date(from: DateComponents(year: 2024, month: 10, day: 21))!
        let expectedProgressDate2 = ProgressDate(date: expectedDate2, completed: false, breathCount: 10, moodChoices: ["Sad"])
        
        let progressDates = ProgressDate.from(tasks)
        
        #expect(progressDates.count == 1)
        #expect(progressDates[0] == expectedProgressDate2)
    }
    
    @Test
    func testDates_emptyInitially() async throws {
        // No need for a mock repository here, as storedDates is initially empty
        let dates = try await ProgressDataSource.dates()
        #expect(dates.isEmpty)
    }

    @Test
    func testDates_fetchesAndSorts() async throws {

    }
}

// Mock TasksRepository to control the response in tests
//fileprivate struct MockTasksRepository: TasksRepositoryProtocol {
//
//}
