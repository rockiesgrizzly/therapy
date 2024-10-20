//
//  TasksService.swift
//  Therapy
//
//  Created by joshmac on 10/15/24.
//

import UIKit

protocol TasksServiceProtocol {
    static var taskResponse: TasksResponse { get async throws }
}

struct TasksLocalService: TasksServiceProtocol {
    static var taskResponse: TasksResponse {
        get async throws {
            guard let localData = localJSON.data(using: .utf8) else { throw TasksLocalServiceError.invalidData }
            
            let response = try JSONDecoder().decode(TasksResponse.self, from: localData)
            return response
        }
    }
}

enum TasksLocalServiceError: Error {
    case invalidData
}

private let localJSON = """
    {
      "tasks": [
        {
          "breathCount": 4,
          "moodChoices": ["happy", "sad", "content", "angry", "frustrated"],
          "dueDate": "2025-01-09"
        },
        {
          "breathCount": 4,
          "moodChoices": ["happy", "sad", "content", "angry", "frustrated"],
          "dueDate": "2024-12-22"
        },
        {
          "breathCount": 4,
          "moodChoices": ["happy", "sad", "content", "angry", "frustrated"],
          "dueDate": "2024-12-02"
        },
        {
          "breathCount": 4,
          "moodChoices": ["happy", "sad", "content", "angry", "frustrated"],
          "dueDate": "2024-11-15"
        },
        {
          "breathCount": 4,
          "moodChoices": ["happy", "sad", "content", "angry", "frustrated"],
          "dueDate": "2024-11-01"
        },
        {
          "breathCount": 4,
          "moodChoices": ["happy", "sad", "content", "angry", "frustrated"],
          "dueDate": "2024-10-22"
        }
      ]
    }
"""
