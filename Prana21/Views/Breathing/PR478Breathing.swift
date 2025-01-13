import SwiftUI

struct Breathing478View: View {
    @State private var breathPhase = "Inhale" // Current phase: Inhale, Hold, Exhale
    @State private var animationValue: CGFloat = 1.0 // Animation value for scaling
    @State private var glowOpacity: Double = 0.0 // Glow animation for hold phase
    @State private var phaseTimer: Timer?
    @State private var isBreathing = false // Breathing session state
    @State private var sessionComplete = false

    // Timing for each phase
    let inhaleDuration: Double = 4.0
    let holdDuration: Double = 7.0
    let exhaleDuration: Double = 8.0
    let totalSessionDuration: Double = 120.0 // Total session duration in seconds

    // Background colors for each phase
    let inhaleColor = Color.blue
    let holdColor = Color.green
    let exhaleColor = Color.purple

    var body: some View {
        VStack(spacing: 30) {
            Text("4-7-8 Breathing")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()

            Text(isBreathing ? "Current Phase: \(breathPhase)" : "Start the Exercise")
                .font(.title2)
                .foregroundColor(.white)

            Spacer()

            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.black, currentPhaseColor]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)

                // Breathing Animation
                ZStack {
                    // Outer Glow for Hold Phase
                    Circle()
                        .fill(currentPhaseColor.opacity(glowOpacity))
                        .frame(width: 300, height: 300)
                        .blur(radius: 50)

                    // Breathing Circle
                    Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [currentPhaseColor, currentPhaseColor.opacity(0.2)]),
                                center: .center,
                                startRadius: 50,
                                endRadius: 150
                            )
                        )
                        .scaleEffect(animationValue)
                        .frame(width: 300, height: 300)
                        .animation(.easeInOut(duration: animationDuration), value: animationValue)

                    // Text for the Phase
                    Text(breathPhase)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }

            Spacer()

            Button(action: toggleBreathing) {
                Text(isBreathing ? "Stop Exercise" : "Start Exercise")
                    .font(.title2)
                    .padding()
                    .foregroundColor(.white)
                    .background(isBreathing ? Color.red : Color.green)
                    .cornerRadius(10)
            }
            .disabled(sessionComplete)
        }
        .padding()
        .onAppear {
            resetExercise()
        }
    }

    private var currentPhaseColor: Color {
        switch breathPhase {
        case "Inhale": return inhaleColor
        case "Hold": return holdColor
        case "Exhale": return exhaleColor
        default: return Color.gray
        }
    }

    private var animationDuration: Double {
        switch breathPhase {
        case "Inhale": return inhaleDuration
        case "Hold": return holdDuration
        case "Exhale": return exhaleDuration
        default: return 0
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
        sessionComplete = false
        glowOpacity = 0.0
        animationValue = 1.0
        breathPhase = "Inhale"

        runPhase()
    }

    private func stopBreathing() {
        isBreathing = false
        sessionComplete = true
        phaseTimer?.invalidate()
        resetExercise()
    }

    private func resetExercise() {
        breathPhase = "Inhale"
        animationValue = 1.0
        glowOpacity = 0.0
    }

    private func runPhase() {
        guard isBreathing else { return }

        switch breathPhase {
        case "Inhale":
            withAnimation {
                animationValue = 1.5 // Expand during inhale
            }
            scheduleNextPhase(after: inhaleDuration, nextPhase: "Hold")

        case "Hold":
            withAnimation {
                glowOpacity = 1.0 // Glow effect during hold
                animationValue = 1.3
            }
            scheduleNextPhase(after: holdDuration, nextPhase: "Exhale")

        case "Exhale":
            withAnimation {
                animationValue = 0.8 // Contract during exhale
                glowOpacity = 0.0
            }
            scheduleNextPhase(after: exhaleDuration, nextPhase: "Inhale")

        default:
            break
        }
    }

    private func scheduleNextPhase(after duration: Double, nextPhase: String) {
        phaseTimer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { _ in
            if self.isBreathing {
                self.breathPhase = nextPhase
                self.runPhase()
            }
        }
    }
}

#Preview {
    Breathing478View()
}
