import SwiftUI

struct AppContentNavigationView: View {
    @StateObject var viewModel = AppContentNavigationViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.currentView {
                case .datesList :
                    DatesListView(viewModel: DatesListViewModel(dateTaskToSelect: $viewModel.dateTaskToSelect, dateTasks: viewModel.dateTasks, colorScheme: colorScheme))
                        .transition(.opacity)
                case .breath:
                    BreathView(viewModel: BreathViewModel(userCompletedBreathTask: $viewModel.userCompletedBreathTask,
                                                          userSkippedToSession: $viewModel.userJoinedFromBreathTask,
                                                          showJoinButton: $viewModel.providerIsReady,
                                                          totalBreathingSeconds: viewModel.currentDateTaskBreathCount,
                                                          colorScheme: colorScheme))
                    .transition(.opacity)
                case .waiting:
                    WaitingView()
                case .join:
                    JoinView(viewModel: JoinViewModel(userCompletedJoin: $viewModel.userCompletedJoinTask, userJoinButton: $viewModel.providerIsReady))
                        .transition(.opacity)
                case .session:
                    SessionView(viewModel: SessionViewModel(userCompletedSessionTask: $viewModel.userCompletedSessionTask))
                case .mood:
                    MoodView(userCompletedMoodTask: $viewModel.userCompletedMoodTask) // TODO: not implemented yet
                        .transition(.opacity)
                }
            }
        }.task {
            await viewModel.refreshForViewAppearance()
        }
    }
}
