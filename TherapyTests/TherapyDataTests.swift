//
//  TherapyDataTests.swift
//  TherapyTests
//
//  Created by joshmac on 10/15/24.
//

@testable import Therapy
import Testing

struct TherapyDataTests {

    @Test func tasksParseSuccess() async throws {
        let response = try await TasksRepository.taskResponse
        guard let tasks = response.tasks else { Issue.record("Response was nil"); return }
        
        #expect(tasks.count > 0)
        
        for task in tasks {
            testResponse(task)
        }
    }
    
    func testResponse(_ response: TasksResponse.TaskReponse) {
        #expect(response.breathCount != nil)
        #expect(response.moodChoices != nil)
        #expect(response.dueDate != nil)
    }

    // I'd normally test the failure here and allow for various test data injection.
}
