//
//  Task.swift
//  Therapy
//
//  Created by joshmac on 10/15/24.
//

import Foundation
import SwiftData


@Model
final class Task {
    var userCompleted: Bool
    var breathCount: Int
    var moodChoices: [String]
    var dueDate: Date
    
    init(userCompleted: Bool = false, breathCount: Int, moodChoices: [String], dueDate: Date) {
        self.userCompleted = userCompleted
        self.breathCount = breathCount
        self.moodChoices = moodChoices
        self.dueDate = dueDate
    }
}
