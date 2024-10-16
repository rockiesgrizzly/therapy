//
//  TasksRepository.swift
//  Therapy
//
//  Created by joshmac on 10/15/24.
//

import Foundation

protocol TasksRepositoryProtocol {
    static var taskResponse: TasksResponse { get async throws }
}

/// Implementation of `TasksRepository`
struct TasksRepository: TasksRepositoryProtocol {
    static var taskResponse: TasksResponse {
        get async throws {
            try await TasksLocalService.taskResponse
        }
    }
}
