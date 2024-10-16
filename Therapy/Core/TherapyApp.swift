//
//  TherapyApp.swift
//  Therapy
//
//  Created by joshmac on 10/15/24.
//

import SwiftUI
import SwiftData

@main
struct TherapyApp: App {
    var body: some Scene {
        WindowGroup {
            TasksView()
        }
        .modelContainer(sharedModelContainer)
    }
    
    // TODO : move this to Data layer
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Task.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
}
