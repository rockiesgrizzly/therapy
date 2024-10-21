import SwiftUI

struct WaitingView: View {
    @State var viewModel = WaitingViewModel()
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                Text(viewModel.titleText)
                    .font(.system(size: 34, weight: .regular))
                    .foregroundStyle(.black)
                Text(viewModel.subtitleText)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.black)
            }
            .padding(.vertical, 300)
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(viewModel.viewBackgroundColor)
        .accessibilityIdentifier("session view")
    }
}
