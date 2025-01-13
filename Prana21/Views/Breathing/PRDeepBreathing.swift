import SwiftUI
import CoreHaptics

struct DeepDiaphragmaticBreathingView: View {
    @State private var inhaleDuration: Double = 4.0
    @State private var exhaleDuration: Double = 6.0
    @State private var breathPhase = "Inhale"
    @State private var diaphragmHeight: CGFloat = 50 // Mimics diaphragm movement
    @State private var abdomenScale: CGFloat = 1.0 // Mimics abdominal expansion
    @State private var elapsedTime = 0.0
    @State private var isBreathing = false
    @State private var sessionComplete = false
    @State private var hapticsEngine: CHHapticEngine?

    let totalSessionDuration: Double = 120.0 // Session length (2 minutes)

    var body: some View {
        VStack(spacing: 30) {
            Text("Deep Diaphragmatic Breathing")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()

            if sessionComplete {
                Text("Session Complete!")
                    .font(.title2)
                    .foregroundColor(.green)
                    .padding()
            } else {
                VStack(spacing: 10) {
                    Text("Current Phase: \(breathPhase)")
                        .font(.title2)
                        .foregroundColor(currentPhaseColor)
                    
                    Text(phaseInstructions)
                        .font(.headline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
            }

            Spacer()

            // Diaphragm and Abdominal Animation
            ZStack {
                // Abdomen expansion
                Circle()
                    .fill(Color.green.opacity(0.5))
                    .scaleEffect(abdomenScale)
                    .frame(width: 200, height: 200)
                    .animation(.easeInOut(duration: currentPhaseDuration), value: abdomenScale)
                
                // Diaphragm movement
               
                
                Text(breathPhase)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(currentPhaseColor)
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
            prepareHaptics()
        }
    }

    // MARK: - Dynamic Instructions
    private var phaseInstructions: String {
        switch breathPhase {
        case "Inhale":
            return "Breathe in slowly through your nose. Allow your diaphragm to expand and fill your belly with air."
        case "Exhale":
            return "Breathe out gently through your mouth. Let your diaphragm contract and your belly deflate."
        default:
            return ""
        }
    }

    private var currentPhaseDuration: Double {
        breathPhase == "Inhale" ? inhaleDuration : exhaleDuration
    }

    private var currentPhaseColor: Color {
        breathPhase == "Inhale" ? Color.blue : Color.green
    }

    // MARK: - Breathing Logic
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
        runPhase()
    }

    private func stopBreathing() {
        isBreathing = false
        sessionComplete = true
    }

    private func runPhase() {
        guard isBreathing else { return }
        
        breathPhase = breathPhase == "Inhale" ? "Exhale" : "Inhale"
        triggerHapticFeedback(for: breathPhase)
        
        if breathPhase == "Inhale" {
            diaphragmHeight = 20
            abdomenScale = 1.2
        } else {
            diaphragmHeight = 50
            abdomenScale = 1.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + currentPhaseDuration) {
            elapsedTime += currentPhaseDuration
            if elapsedTime >= totalSessionDuration {
                stopBreathing()
            } else {
                runPhase()
            }
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

#Preview {
    DeepDiaphragmaticBreathingView()
}

