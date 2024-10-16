//
//  TasksResponse.swift
//  Therapy
//
//  Created by joshmac on 10/15/24.
//

import Foundation

struct TasksResponse: Codable {
    let tasks: [TaskReponse]?
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tasks = try container.decode([TasksResponse.TaskReponse].self, forKey: .tasks)
    }
    
    struct TaskReponse: Codable {
        let breathCount: Int?
        let moodChoices: [String]?
        let dueDate: String?
        
        init(from decoder: any Decoder) throws {
            let container: KeyedDecodingContainer<TasksResponse.TaskReponse.CodingKeys> = try decoder.container(keyedBy: TasksResponse.TaskReponse.CodingKeys.self)
            self.breathCount = try container.decode(Int.self, forKey: TasksResponse.TaskReponse.CodingKeys.breathCount)
            self.moodChoices = try container.decode([String].self, forKey: TasksResponse.TaskReponse.CodingKeys.moodChoices)
            self.dueDate = try container.decode(String.self, forKey: TasksResponse.TaskReponse.CodingKeys.dueDate)
        }
    }
}
