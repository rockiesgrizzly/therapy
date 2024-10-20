import SwiftUI

struct SessionView: View {
    @ObservedObject var viewModel: SessionViewModel
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                Text("In Session")
                    .font(.system(size: 34, weight: .regular))
                    .foregroundStyle(.black)
                Button(action: userTappedButton) {
                    Text("Exit")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.white)
                }
                .frame(width: 115, height: 50)
                .background(Color.black)
                .cornerRadius(10)
                .accessibilityIdentifier("Exit")
                .buttonStyle(CustomButtonStyle())
            }
            
            .padding(.vertical, 363)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(viewModel.viewBackgroundColor)
        .accessibilityIdentifier("session view")
    }
    
    private func userTappedButton() {
        viewModel.userCompletedSessionTask = true
    }
}
