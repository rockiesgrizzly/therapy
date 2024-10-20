import SwiftUI

struct DatesListView: View {
    var viewModel: DatesListViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Text(viewModel.titleText)
                .font(.system(size: 34, weight: .bold))
            VStack(spacing: 16) {
                ForEach(Array(viewModel.dateTasks.enumerated()), id: \.element.id) { index, task in
                    let detailViewModel = DateDetailViewModel(date: dateString(from: task.date),
                                                        enabled: task.enabled,
                                                        completed: task.completed,
                                                        colorScheme: colorScheme)
                    DateDetailView(viewModel: detailViewModel)
                        .onTapGesture {
                            guard task.enabled == true else { return }
                            viewModel.dateTaskToSelect = task
                        }
                }
            }
            .padding(.vertical, 36)
            Spacer()
        }.padding(.vertical, 90)
    }
    
    func dateString(from date: Date) -> String { date.formatted(.dateTime.month(.wide).day()) }
}
