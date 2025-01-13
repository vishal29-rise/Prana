//
//  PRGuidedVisualizationView.swift
//  Prana21
//
//  Created by Vishal Thakur on 11/01/25.
//

import SwiftUI
import CoreHaptics

struct GuidedVisualizationView: View {
    @State private var breathPhase = "Inhale" // Current phase: Inhale, Hold, Exhale
    @State private var animationValue: CGFloat = 1.0 // Animation value for scaling
    @State private var glowOpacity: Double = 0.0 // Glow animation for hold phase
    @State private var phaseTimer: Timer?
    @State private var isBreathing = false // Breathing session state
    @State private var sessionComplete = false
    @State private var affirmationIndex = 0

    // Core Haptics Engine
    @State private var hapticsEngine: CHHapticEngine?

    // Timing for each phase
    let inhaleDuration: Double = 4.0
    let holdDuration: Double = 7.0
    let exhaleDuration: Double = 8.0

    // Visualization Prompts and Affirmations
    let affirmations = [
        "Imagine a warm golden light filling your body with peace.",
        "Hold onto this calmness as you visualize your happiest moment.",
        "Exhale stress, letting it dissolve into the air.",
        "Picture yourself achieving something meaningful.",
        "Feel gratitude radiating through your body with every breath."
    ]

    // Colors for each phase
    let inhaleColor = Color.blue
    let holdColor = Color.green
    let exhaleColor = Color.purple

    var body: some View {
        VStack(spacing: 30) {
            Text("Guided Visualization")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.green)
                .padding()

            Text(isBreathing ? affirmations[affirmationIndex] : "Tap Start to Begin")
                .font(.title3)
                .italic()
                .foregroundColor(.blue)
                .padding()
                .multilineTextAlignment(.center)

            Spacer()

            ZStack {
                // Background Gradient
//                LinearGradient(
//                    gradient: Gradient(colors: [Color.black, currentPhaseColor]),
//                    startPoint: .top,
//                    endPoint: .bottom
//                )
//                .edgesIgnoringSafeArea(.all)

                // Breathing Animation
                ZStack {
                    // Outer Glow for Hold Phase
                    Circle()
                        .fill(currentPhaseColor.opacity(glowOpacity))
                        .frame(width: 350, height: 350)
                        .blur(radius: 50)

                    // Breathing Circle
                    Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [currentPhaseColor, currentPhaseColor.opacity(0.3)]),
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
            prepareHaptics()
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
        affirmationIndex = 0
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
            triggerHapticFeedback() // Trigger haptic feedback
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
                if nextPhase == "Inhale" {
                    affirmationIndex = (affirmationIndex + 1) % affirmations.count
                }
                self.breathPhase = nextPhase
                self.runPhase()
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
    GuidedVisualizationView()
}
