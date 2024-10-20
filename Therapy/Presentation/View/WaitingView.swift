import SwiftUI

struct WaitingView: View {
    @ObservedObject var viewModel: WaitingViewModel
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                Text(viewModel.titleText)
                    .font(.system(size: 34, weight: .regular))
                    .foregroundStyle(.black)
                Button(action: userTappedButton) {
                    Text(viewModel.buttonText)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.black)
                }
                .frame(width: 115, height: 50)
                .background(viewModel.buttonBackgroundColor)
                .cornerRadius(10)
                .accessibilityIdentifier(viewModel.buttonText)
                .buttonStyle(CustomButtonStyle())
            }
            
            .padding(.vertical, 363)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(viewModel.viewBackgroundColor)
        .accessibilityIdentifier("waiting view")
    }
    
    private func userTappedButton() {
        viewModel.userCompletedWaiting = true
    }
}
