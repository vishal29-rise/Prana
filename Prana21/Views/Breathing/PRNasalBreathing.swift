import SwiftUI
import CoreHaptics

struct NasalBreathingFocusView: View {
    @State private var breathPhase = "Inhale"
    @State private var arcRotation: Double = 0
    @State private var waveOffset: CGFloat = -200
    @State private var glowingArcScale: CGFloat = 1.0
    @State private var elapsedTime = 0.0
    @State private var isBreathing = false
    @State private var sessionComplete = false
    @State private var hapticsEngine: CHHapticEngine?

    // Breathing Phases and Timings
    let phases = ["Inhale", "Hold", "Exhale"]
    let durations: [Double] = [4.0, 4.0, 6.0]
    let totalSessionDuration: Double = 60.0

    @State private var phaseIndex = 0

    var body: some View {
        ZStack {
            // Background Gradient
            AngularGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple, Color.cyan, Color.blue]),
                center: .center
            )
            .ignoresSafeArea()

            VStack {
                // Title and Phase Display
                Text("Nasal Breathing Focus")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()

                if sessionComplete {
                    Text("Session Complete!")
                        .font(.title2)
                        .foregroundColor(.green)
                        .padding()
                } else {
                    Text("Current Phase: \(breathPhase)")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                }

                Spacer()

                // Dynamic Breathing Animation
                ZStack {
                    // Rotating Glowing Arcs
                    Circle()
                        .trim(from: 0, to: 0.5)
                        .stroke(
                            getPhaseColor(for: breathPhase).opacity(0.8),
                            lineWidth: 20
                        )
                        .frame(width: 250 * glowingArcScale, height: 250 * glowingArcScale)
                        .rotationEffect(.degrees(arcRotation))
                        .blur(radius: 10)
                        .animation(.easeInOut(duration: currentPhaseDuration), value: glowingArcScale)
                        .animation(.easeInOut(duration: currentPhaseDuration), value: arcRotation)

                    Circle()
                        .trim(from: 0, to: 0.5)
                        .stroke(
                            getPhaseColor(for: breathPhase).opacity(0.6),
                            lineWidth: 10
                        )
                        .frame(width: 200, height: 200)
                        .rotationEffect(.degrees(-arcRotation))
                        .animation(.easeInOut(duration: currentPhaseDuration), value: arcRotation)

                    // Waveform for Airflow
                    WaveformView(offset: waveOffset, color: getPhaseColor(for: breathPhase))
                        .frame(height: 200)
                        .animation(
                            .easeInOut(duration: currentPhaseDuration).repeatForever(autoreverses: false),
                            value: waveOffset
                        )

                    // Breathing Phase Label
                    Text(breathPhase)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .frame(width: 300, height: 300)

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
        glowingArcScale = 1.0
        waveOffset = -200
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

        // Update animation properties
        glowingArcScale = currentPhase == "Inhale" ? 1.5 : (currentPhase == "Exhale" ? 0.5 : 1.0)
        waveOffset = waveOffset == -200 ? 200 : -200
        arcRotation += 120

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
        case "Inhale": return Color.blue
        case "Hold": return Color.purple
        case "Exhale": return Color.cyan
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

        let intensity: Float = phase == "Inhale" ? 1.0 : 0.6
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

// MARK: - Waveform View
struct WaveformView: View {
    let offset: CGFloat
    let color: Color

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                let centerY = height / 2

                path.move(to: CGPoint(x: 0, y: centerY))
                for x in stride(from: 0, through: width, by: 1) {
                    let relativeX = x / width
                    let sineWave = sin((relativeX + offset / 200) * 2 * .pi)
                    let y = centerY + sineWave * 40
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            .stroke(color, lineWidth: 2)
        }
    }
}

#Preview {
    NasalBreathingFocusView()
}

