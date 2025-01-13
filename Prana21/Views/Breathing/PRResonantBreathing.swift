import SwiftUI

struct ResonantBreathingView: View {
    @State private var isInhaling = true // Track inhale/exhale state
    @State private var breathScale: CGFloat = 1.0 // Scale for the main circle
    @State private var animationProgress = 0.0 // For gradient animation
    @State private var totalElapsedTime = 0.0 // Tracks total session time
    @State private var isBreathing = false // Breathing session state

    let inhaleDuration: Double = 4.0 // Inhale duration in seconds
    let exhaleDuration: Double = 6.0 // Exhale duration in seconds
    let totalSessionDuration: Double = 60.0 // Total session duration in seconds

    var body: some View {
        VStack(spacing: 20) {
            Text("Resonant Breathing")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()

            Text(isInhaling ? "Inhale Slowly" : "Exhale Gently")
                .font(.title2)
                .foregroundColor(.white)
                .padding()

            Spacer()

            // Dynamic breathing animation
            ZStack {
                // Background gradient ring
                Circle()
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [.blue, .purple, .blue]),
                            center: .center,
                            startAngle: .degrees(animationProgress * 360),
                            endAngle: .degrees(animationProgress * 360 + 360)
                        ),
                        lineWidth: 20
                    )
                    .frame(width: 300, height: 300)
                    .rotationEffect(.degrees(animationProgress * 360))
                    .animation(.linear(duration: inhaleDuration + exhaleDuration), value: animationProgress)

                // Main expanding and contracting circle
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.3)]),
                            center: .center,
                            startRadius: 10,
                            endRadius: 150
                        )
                    )
                    .frame(width: 300 * breathScale, height: 300 * breathScale)
                    .animation(.easeInOut(duration: isInhaling ? inhaleDuration : exhaleDuration), value: breathScale)
            }

            Spacer()

            Button(action: toggleBreathing) {
                Text(isBreathing ? "Stop" : "Start")
                    .font(.title2)
                    .padding()
                    .foregroundColor(.white)
                    .background(isBreathing ? Color.red : Color.green)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(LinearGradient(
            gradient: Gradient(colors: [Color.black, Color.blue]),
            startPoint: .top,
            endPoint: .bottom
        ))
        .ignoresSafeArea()
        .onAppear {
            resetBreathing()
        }
    }

    private func toggleBreathing() {
        if isBreathing {
            stopBreathing()
        } else {
            startBreathing()
        }
    }

    private func startBreathing() {
        isBreathing = true
        totalElapsedTime = 0.0
        isInhaling = true
        breathScale = 1.2
        animationProgress = 0.0

        // Start the animation loop
        runBreathingCycle()
    }

    private func stopBreathing() {
        isBreathing = false
    }

    private func resetBreathing() {
        isInhaling = true
        breathScale = 1.0
        animationProgress = 0.0
        totalElapsedTime = 0.0
    }

    private func runBreathingCycle() {
        guard isBreathing else { return }

        let duration = isInhaling ? inhaleDuration : exhaleDuration

        withAnimation(Animation.easeInOut(duration: duration)) {
            breathScale = isInhaling ? 1.5 : 0.8 // Expand on inhale, contract on exhale
            animationProgress += duration / (inhaleDuration + exhaleDuration) // Advance gradient
        }

        // Schedule the next phase
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            if self.isBreathing {
                self.isInhaling.toggle() // Switch between inhale and exhale
                self.runBreathingCycle() // Continue the cycle
            }
        }
    }
}

#Preview {
    ResonantBreathingView()
}
