import SwiftUI

struct DateDetailView: View {
    var viewModel: DateDetailViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack() {
            Text("\(viewModel.date)")
                .font(.system(size: 17))
                .padding()
                .foregroundStyle(viewModel.dateTextColor)
            Spacer()
            Image(systemName: viewModel.systemImage.rawValue)
                .padding(.trailing, 18.5)
                .foregroundStyle(viewModel.foregroundColor)
        }
        .background(viewModel.completed ? viewModel.completedColor : Color.clear)
        .cornerRadius(10)
        .padding(.horizontal, 32)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(viewModel.borderColor, lineWidth: 1)
                .padding(.horizontal, 32)
        )
        .accessibilityIdentifier("date detail view \(viewModel.date)")
    }
}

