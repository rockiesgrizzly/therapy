//
//  TasksResponse.swift
//  Therapy
//
//  Created by joshmac on 10/15/24.
//

import Foundation

struct TasksResponse: Codable {
    let tasks: [Task]?
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tasks = try container.decode([Task].self, forKey: .tasks)
    }
    
    init(tasks: [Task]? = nil) {
        self.tasks = tasks
    }
    
    struct Task: Codable {
        let breathCount: Float?
        let moodChoices: [String]?
        let dueDate: String?
        
        init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.breathCount = try container.decode(Float.self, forKey: .breathCount)
            self.moodChoices = try container.decode([String].self, forKey: .moodChoices)
            self.dueDate = try container.decode(String.self, forKey: .dueDate)
        }
        
        init(breathCount: Float? = nil, moodChoices: [String]? = nil, dueDate: String? = nil) {
            self.breathCount = breathCount
            self.moodChoices = moodChoices
            self.dueDate = dueDate
        }
    }
}
