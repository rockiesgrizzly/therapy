import SwiftUI

struct BreathView: View {
    @ObservedObject var viewModel: BreathViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.title)
                .font(.system(size: 34, weight: .bold))
            Text("\(Int(viewModel.totalBreathingSeconds) - viewModel.currentSecond)")
                .font(.system(size: 60, weight: .bold))
                .padding(.vertical, 30)
                .accessibilityIdentifier("breathing total seconds")
            Circle()
                .fill(circleColor)
                .frame(width: 100, height: 100)
                .scaleEffect(viewModel.scale)
                .animation(.easeInOut(duration: 1), value: viewModel.scale) // Animate scale changes
                .offset(y: 30)
                .accessibilityIdentifier("breathing demonstration circle")
            
            if viewModel.showJoinButton {
                VStack {
                    Text(viewModel.providerText)
                        .font(.system(size: 17, weight: .regular))
                    
                    Button(action: userTappedButton) {
                        Text(viewModel.joinText)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(.black)
                    }
                    .frame(width: 115, height: 50)
                    .background(buttonBackgroundColor)
                    .cornerRadius(10)
                    .accessibilityIdentifier(viewModel.joinText)
                    .buttonStyle(CustomButtonStyle())
                }.offset(y: 204)
            }
            Spacer()
        }
        .padding(.vertical, 90)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(viewModel.backgroundColor)
        .onAppear {
            viewModel.respondToOnAppear()
        }
        .accessibilityIdentifier("breath view")
    }
    
    var circleColor: Color {
        Color(red: 189 / 255, green: 177 / 255, blue: 250 / 255)
    }
    
    private func userTappedButton() {
        viewModel.userCompletedBreathTask = true
        viewModel.userSkippedToSession = true
    }
    
    private var buttonBackgroundColor: Color {
        Color(red: 215 / 255, green: 240 / 255, blue: 190 / 255)
    }
}
