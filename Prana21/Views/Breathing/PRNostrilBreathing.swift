import SwiftUI
import CoreHaptics

struct PRNostrilBreathingEnhancedView: View {
    @State private var breathPhase = "Inhale (Left Nostril)"
    @State private var arcRotation: Double = 0
    @State private var particlesOffset: CGFloat = -300
    @State private var isBreathing = false
    @State private var sessionComplete = false
    @State private var elapsedTime = 0.0
    @State private var hapticsEngine: CHHapticEngine?

    // Phases and Timings
    let phases = [
        "Inhale (Left Nostril)",
        "Hold",
        "Exhale (Right Nostril)",
        "Inhale (Right Nostril)",
        "Hold",
        "Exhale (Left Nostril)"
    ]
    let durations: [Double] = [4.0, 4.0, 6.0, 4.0, 4.0, 6.0]
    let totalSessionDuration: Double = 60.0

    @State private var phaseIndex = 0

    var body: some View {
        ZStack {
            // Background Gradient
            RadialGradient(
                gradient: Gradient(colors: [Color.black, getPhaseColor(for: breathPhase)]),
                center: .center,
                startRadius: 50,
                endRadius: 500
            )
            .ignoresSafeArea()

            VStack {
                // Title and Instructions
                Text("Nostril Breathing")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()

                if sessionComplete {
                    Text("Session Complete!")
                        .font(.title2)
                        .foregroundColor(.green)
                        .padding()
                } else {
                    Text(breathPhase)
                        .font(.title2)
                        .foregroundColor(.white)
                        .italic()
                        .padding()
                }

                Spacer()

                // Arc Animation
                ZStack {
                    Circle()
                        .stroke(getPhaseColor(for: breathPhase).opacity(0.3), lineWidth: 20)

                    Circle()
                        .trim(from: 0, to: 0.5)
                        .stroke(getPhaseColor(for: breathPhase), lineWidth: 20)
                        .rotationEffect(.degrees(arcRotation))
                        .animation(.easeInOut(duration: currentPhaseDuration), value: arcRotation)

                    // Particles for Nostril Breathing
                    ForEach(0..<12) { i in
                        Circle()
                            .fill(getPhaseColor(for: breathPhase))
                            .frame(width: 10, height: 10)
                            .offset(y: particlesOffset)
                            .rotationEffect(.degrees(Double(i) * 30))
                            .animation(
                                .easeInOut(duration: currentPhaseDuration).repeatForever(autoreverses: false),
                                value: particlesOffset
                            )
                    }

                    // Center Text
                    Text(breathPhase)
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .frame(width: 300, height: 300)
                .onAppear {
                    particlesOffset = -300
                }

                Spacer()

                // Start/Stop Button
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
        }
        .onAppear {
            prepareHaptics()
        }
    }

    // MARK: - Breathing Control
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
        elapsedTime = 0.0
        phaseIndex = 0
        arcRotation = 0
        runPhase()
    }

    private func stopBreathing() {
        isBreathing = false
        sessionComplete = true
    }

    private func runPhase() {
        guard isBreathing else { return }

        let currentPhase = phases[phaseIndex]
        breathPhase = currentPhase
        triggerHapticFeedback(for: currentPhase)

        // Animate the arc and particles
        if currentPhase.contains("Inhale") || currentPhase.contains("Exhale") {
            arcRotation += 180
            particlesOffset = particlesOffset == -300 ? 300 : -300
        }

        // Schedule the next phase
        DispatchQueue.main.asyncAfter(deadline: .now() + currentPhaseDuration) {
            advancePhase()
        }
    }

    private func advancePhase() {
        if !isBreathing { return }

        phaseIndex = (phaseIndex + 1) % phases.count
        elapsedTime += currentPhaseDuration

        if elapsedTime >= totalSessionDuration {
            stopBreathing()
        } else {
            runPhase()
        }
    }

    private var currentPhaseDuration: Double {
        durations[phaseIndex]
    }

    private func getPhaseColor(for phase: String) -> Color {
        switch phase {
        case "Inhale (Left Nostril)", "Inhale (Right Nostril)": return Color.blue
        case "Hold": return Color.green
        case "Exhale (Left Nostril)", "Exhale (Right Nostril)": return Color.orange
        default: return Color.gray
        }
    }

    // MARK: - Haptics
    private func prepareHaptics() {
        do {
            hapticsEngine = try CHHapticEngine()
            try hapticsEngine?.start()
        } catch {
            print("Haptics error: \(error.localizedDescription)")
        }
    }

    private func triggerHapticFeedback(for phase: String) {
        guard let hapticsEngine = hapticsEngine else { return }

        var intensity: Float = 0.5
        if phase.contains("Inhale") {
            intensity = 1.0
        } else if phase.contains("Exhale") {
            intensity = 0.7
        }

        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: intensity)
        let event = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [sharpness],
            relativeTime: 0
        )

        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try hapticsEngine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Haptics playback error: \(error.localizedDescription)")
        }
        
    }
}

#Preview {
    PRNostrilBreathingEnhancedView()
}
