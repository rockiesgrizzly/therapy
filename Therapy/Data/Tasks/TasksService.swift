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
            guard let url = Bundle.main.url(forResource: "tasks", withExtension: "json") else { throw TasksLocalServiceError.invalidURL  }
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(TasksResponse.self, from: data)
            return response
        }
    }
}

enum TasksLocalServiceError: Error {
    case invalidURL
}
