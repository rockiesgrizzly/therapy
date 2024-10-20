import SwiftUI

// TODO: build as bonus

struct MoodView: View {
    @Binding var userCompletedMoodTask: Bool
    
    var body: some View {
        Spacer()
            .accessibilityIdentifier("mood view")
    }
       
}
