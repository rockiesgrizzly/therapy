@testable import Therapy
import Foundation
import Testing
import SwiftUICore

@Suite
struct TherapyPresentationTests {
    // MARK: - AppContentNavigationViewModel Tests

    @Test
    @MainActor
    func testAppContentNavigationViewModel_initialization() {
        let viewModel = AppContentNavigationViewModel()
        #expect(viewModel.dateTasks.isEmpty)
        #expect(viewModel.currentView == .datesList)
        #expect(viewModel.dateTaskToSelect == nil)
        #expect(viewModel.userCompletedBreathTask == false)
        #expect(viewModel.userJoinedFromBreathTask == false)
        #expect(viewModel.userCompletedWaitingTask == false)
        #expect(viewModel.userCompletedSessionTask == false)
        #expect(viewModel.userCompletedMoodTask == false)
    }

    // ... (Other AppContentNavigationViewModel tests - refer to the previous response) ...

    // MARK: - BreathViewModel Tests

    @Test
    func testBreathViewModel_initialization() {
        let viewModel = BreathViewModel(userCompletedBreathTask: falseBinding, userSkippedToSession: falseBinding, totalBreathingSeconds: 60)
        #expect(viewModel.providerIsReady == true)
        #expect(viewModel.currentSecond == 0)
        #expect(viewModel.scale == 1.0)
        #expect(viewModel.totalBreathingSeconds == 60)
    }

    @Test
    func testBreathViewModel_respondToOnAppear() async throws {
        let viewModel = BreathViewModel(userCompletedBreathTask: falseBinding, userSkippedToSession: falseBinding, totalBreathingSeconds: 0.1)
        viewModel.respondToOnAppear()

        Task {
            // Wait .2 seconds
            try await Task.sleep(nanoseconds: 200_000_000)

            // Check if the task is done (completed or cancelled)
            #expect(viewModel.userCompletedBreathTask == true)
        }
    }

    // MARK: - DateDetailViewModel Tests

    @Test
    func testDateDetailViewModel_initialization() {
        let viewModel = DateDetailViewModel(date: "2024-10-20", enabled: true, completed: false, colorScheme: .light)
        #expect(viewModel.date == "2024-10-20")
        #expect(viewModel.enabled == true)
        #expect(viewModel.completed == false)
        #expect(viewModel.colorScheme == .light)
    }

    @Test
    func testDateDetailViewModel_systemImage() {
        let viewModel1 = DateDetailViewModel(date: "2024-10-20", enabled: false, completed: false, colorScheme: .light)
        #expect(viewModel1.systemImage == .lock)

        let viewModel2 = DateDetailViewModel(date: "2024-10-20", enabled: true, completed: false, colorScheme: .light)
        #expect(viewModel2.systemImage == .chevronRight)

        let viewModel3 = DateDetailViewModel(date: "2024-10-20", enabled: true, completed: true, colorScheme: .light)
        #expect(viewModel3.systemImage == .checkmark)
    }

    // ... (Add tests for colors and other properties) ...

    // MARK: - DatesListViewModel Tests

    @Test
    func testDatesListViewModel_initialization() {
        let dateTasks = [
            DateTask(date: Date(), completed: false, breathCount: 5, moodChoices: ["Happy"])
        ]
        let viewModel = DatesListViewModel(dateTaskToSelect: nilBinding, dateTasks: dateTasks)
        #expect(viewModel.dateTasks.count == 1)
    }

    // MARK: - SessionViewModel Tests

    // Add tests for colors and other properties

    // MARK: - WaitingViewModel Tests

    private var falseBinding: Binding<Bool> {
        Binding<Bool>(
            get: { false },
            set: { _ in }
        )
    }
    
    private var nilBinding: Binding<DateTask?> {
        Binding<DateTask?>(
            get: { nil },
            set: { _ in }
        )
    }
}

