//
//  PRBoxBreathingView.swift
//  Prana21
//
//  Created by Vishal Thakur on 29/12/24.
//

import SwiftUI
import CoreHaptics

struct PRBoxBreathingView: View {
    @State private var breathPhase = "Inhale" // Current phase: Inhale, Hold, Exhale
    @State private var lastBreathPhase = "Inhale"
    @State private var boxScale: CGFloat = 1.0 // Controls the square size animation
    @State private var totalElapsedTime = 0.0 // Tracks total session time
    @State private var isExercising = false // Exercise status
    @State private var sessionComplete = false // Session status
    @State private var phaseTimer: Timer?
    @State private var session: Timer?
    @State private var isFirstTime: Bool = true
    // Core Haptics Engine
    @State private var hapticsEngine: CHHapticEngine?
    

    // Timing for each phase (4 seconds for inhale, hold, exhale)
    @State private var phaseDuration: Double = 4.0
    let totalSessionDuration: Double = 60.0 // Total session duration in seconds

    // Colors for different phases
    let inhaleColor = Color.blue
    let holdColor = Color.green
    let exhaleColor = Color.orange

    var body: some View {
        VStack(spacing: 20) {
            Text("Box Breathing Exercise")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            if sessionComplete {
                // Session complete message
                Text("Session Complete!")
                    .font(.title)
                    .foregroundColor(.green)
                    .padding()
            } else {
                
                Text("Current Phase: \(breathPhase)")
                    .font(.title2)
                    .foregroundColor(currentPhaseColor)
                    .padding()
            }

            Spacer()

            // Square Box Animation
            ZStack {
                Rectangle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 10)
                    .frame(width: 200, height: 200)

                Rectangle()
                    .fill(currentPhaseColor.opacity(0.6))
                    .frame(width: 200 * boxScale, height: 200 * boxScale)
                    .animation(.easeInOut(duration: phaseDuration), value: boxScale)

                if sessionComplete {
                    Text("Done")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                } else {
                    Text(breathPhase)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(currentPhaseColor)
                }
            }

            Spacer()

            Button(action: toggleExercise) {
                Text(getCTA())
                    .font(.title2)
                    .padding()
                    .foregroundColor(.white)
                    .background(isExercising ? Color.red : Color.green)
                    .cornerRadius(8)
            }
            .disabled(sessionComplete) // Disable button after session completion
        }
        .padding()
    }
    
    private func getCTA() -> String{
        if isFirstTime {
            if isExercising {
                return "Next Phase"
            } else {
                return "Try Demo"
            }
        } else {
            return isExercising ? "Stop Exercise" : "Start Exercise"
        }
    }

    private var currentPhaseColor: Color {
        switch breathPhase {
        case "Inhale":
            return inhaleColor
        case "Hold":
            return holdColor
        case "Exhale":
            return exhaleColor
        default:
            return Color.gray
        }
    }

    private func toggleExercise() {
        if !isFirstTime {
            if isExercising {
                stopExercise()
            } else {
                startExercise()
            }
        } else {
            if isExercising {
                advancePhase()
            } else {
                startExercise()
            }
        }
    }

    private func startExercise() {
        isExercising = true
        sessionComplete = false
        phaseDuration = totalElapsedTime / 4.0
        totalElapsedTime = 0.0
        breathPhase = "Inhale"
        boxScale = 1.0
        startPhase()
        startSessionTimer()
    }

    private func stopExercise() {
        isExercising = false
        sessionComplete = true
        phaseTimer?.invalidate()
    }

    private func startPhase() {
        guard isExercising else { return }

        // Set the box scale for animation
        boxScale = breathPhase == "Inhale" ? 1.5 : (breathPhase == "Exhale" ? 0.5 : 1.0)
        triggerHapticFeedback()

        if !isFirstTime {
            // Timer to handle phase duration
            phaseTimer = Timer.scheduledTimer(withTimeInterval: phaseDuration, repeats: false) { _ in
                advancePhase()
            }
        }
    }

    private func advancePhase() {
        if !isExercising { return }

        switch breathPhase {
        case "Inhale":
            breathPhase = "Hold"
        case "Hold":
            breathPhase = lastBreathPhase == "Inhale" ? "Exhale" : "Inhale"
            if isFirstTime && lastBreathPhase == "Exhale"{
                isFirstTime = false
                isExercising = false
                
                //totalElapsedTime = 0.0
            }
            lastBreathPhase = breathPhase
        case "Exhale":
            breathPhase = "Hold"
        default:
            break
        }
        startPhase()
    }

    private func startSessionTimer() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            totalElapsedTime += 0.1
            if !isFirstTime && !isExercising {
                timer.invalidate()
            }
            if !isFirstTime && isExercising {
                if totalElapsedTime >= totalSessionDuration {
                    timer.invalidate()
                    sessionComplete = true
                    isExercising = false
                    phaseTimer?.invalidate()
                }
            }
        }
    }
    
    // MARK: - Core Haptics
        private func prepareHaptics() {
            do {
                hapticsEngine = try CHHapticEngine()
                try hapticsEngine?.start()
            } catch {
                print("Haptics error: \(error.localizedDescription)")
            }
        }

        private func triggerHapticFeedback() {
            guard let hapticsEngine = hapticsEngine else { return }

            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
            let event = CHHapticEvent(
                eventType: .hapticTransient,
                parameters: [intensity, sharpness],
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
    PRBoxBreathingView()
}
