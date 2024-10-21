
@testable import Therapy
import Foundation
import Testing

@Suite
struct TherapyDataTests {
    @Test
    func testProgressDateFromTask_validDueDate() {
        let task = TasksResponse.Task(breathCount: 5, moodChoices: ["Happy"], dueDate: "2024-10-20")
        let expectedDate = Calendar.current.date(from: DateComponents(year: 2024, month: 10, day: 20))!
        let expectedProgressDate = ProgressDate(date: expectedDate, completed: false, breathCount: 5, moodChoices: ["Happy"])
        
        let progressDate = ProgressDate.from(task)
        
        #expect(progressDate == expectedProgressDate)
    }

    @Test
    func testProgressDateFromTask_invalidDueDate() {
        let task = TasksResponse.Task(breathCount: 5, moodChoices: ["Happy"], dueDate: "invalid date")
        let progressDate = ProgressDate.from(task)
        #expect(progressDate == nil)
    }

    @Test
    func testProgressDateFromTask_nilDueDate() {
        let task = TasksResponse.Task(breathCount: 5, moodChoices: ["Happy"], dueDate: nil)
        let progressDate = ProgressDate.from(task)
        #expect(progressDate == nil)
    }

    @Test
    func testProgressDateFromTasks_validTasks() {
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
    func testProgressDateFromTasks_invalidTasks() {
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
    func testProgressDateFromTasks_empty() {
        let tasks: [TasksResponse.Task] = []
        let progressDates = ProgressDate.from(tasks)
        #expect(progressDates.isEmpty)
    }

    // MARK: - TasksResponse Tests

    @Test
    func testTasksResponse_initFromDecoder() throws {
        let jsonData = """
        {
          "tasks": [
            {
              "breathCount": 4,
              "moodChoices": ["happy", "sad"],
              "dueDate": "2024-10-20"
            }
          ]
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let tasksResponse = try decoder.decode(TasksResponse.self, from: jsonData)

        #expect(tasksResponse.tasks?.count == 1)
        #expect(tasksResponse.tasks?[0].breathCount == 4)
        #expect(tasksResponse.tasks?[0].moodChoices == ["happy", "sad"])
        #expect(tasksResponse.tasks?[0].dueDate == "2024-10-20")
    }

    @Test
    func testTasksResponse_initFromTasks() {
        let task = TasksResponse.Task(breathCount: 4, moodChoices: ["happy", "sad"], dueDate: "2024-10-20")
        let tasksResponse = TasksResponse(tasks: [task])

        #expect(tasksResponse.tasks?.count == 1)
        #expect(tasksResponse.tasks?[0].breathCount == 4)
        #expect(tasksResponse.tasks?[0].moodChoices == ["happy", "sad"])
        #expect(tasksResponse.tasks?[0].dueDate == "2024-10-20")
    }

    // MARK: - TasksLocalService Tests

    @Test
    func testTasksLocalService_taskResponse() async throws {
        let taskResponse = try await TasksLocalService.taskResponse
        #expect(taskResponse.tasks?.count == 6)
    }
    
    // MARK: - TasksRepository Tests

    @Test
    func testTasksRepository_taskResponse() async throws {
        let taskResponse = try await TasksRepository.taskResponse(service: MockTasksService.self)
        #expect(taskResponse.tasks?.count == 1)
    }
    
    // More tests for TasksRepository, ProgressDataSource, ProviderDataSource, ProviderRepository
}

struct MockTasksService: TasksServiceProtocol {
    static var taskResponse: TasksResponse {
        get async throws {
            // Return a mock TasksResponse for testing
            return TasksResponse(tasks: [
                .init(breathCount: 5, moodChoices: ["Happy"], dueDate: "2024-10-20")
            ])
        }
    }
}

