//
//  PRBellyBreathingView.swift
//  Prana21
//
//  Created by Vishal Thakur on 29/12/24.
//

import SwiftUI

struct PRBellyBreathingView: View {
    @State private var breathPhase = "Inhale" // Current phase (Inhale, Hold, Exhale)
    @State private var progress = 0.0
    @State private var inhaleTimer: Timer?
    @State private var holdTimer: Timer?
    @State private var exhaleTimer: Timer?
    @State private var totalTimer: Timer?
    @State private var totalElapsedTime = 0.0
    @State private var sessionComplete = false
    
    // State to track whether the exercise is in progress
    @State private var isExercising = false

    // Stats Tracking
    @State private var breathDurations: [Double] = [] // Records duration of each full breath
    @State private var inhaleDurations: [Double] = [] // Records each inhale duration
    @State private var exhaleDurations: [Double] = [] // Records each exhale duration
    @State private var currentPhaseStartTime: Date?  // To measure phase durations

    // Total session time (2 minutes)
    let totalSessionDuration: Double = 60.0 // 120 seconds = 2 minutes

    var body: some View {
        VStack(spacing: 20) {
            Text("Belly Breathing Exercise")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            if sessionComplete {
                // Display stats after the session
                VStack(alignment: .leading, spacing: 10) {
                    Text("Session Complete!").font(.headline).foregroundColor(.green)
                    Text("Breath Score: \(calculateBreathScore())")
                    Text("Average Breaths Per Minute: \(String(format: "%.1f", averageBreathsPerMinute()))")
                    Text("Average Inhale Time: \(String(format: "%.1f", averageInhaleTime())) sec")
                    Text("Average Exhale Time: \(String(format: "%.1f", averageExhaleTime())) sec")
                    Text("Longest Breath: \(String(format: "%.1f", longestBreath())) sec")
                    Text("Shortest Breath: \(String(format: "%.1f", shortestBreath())) sec")
                }
                .padding()
                .font(.title3)
                .foregroundColor(.black)
            } else {
                Text("Focus on the rise and fall of your belly as you breathe.")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Text("Current Status: \(breathPhase)")
                    .font(.title2)
                    .foregroundColor(breathPhase == "Inhale" ? .blue : breathPhase == "Hold" ? .green : .orange)
                    .padding()
            }
            
            Spacer()
            
            // Circular progress indicator
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 10)
                    .frame(width: 200, height: 200)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(progress))
                    .stroke(breathPhase == "Inhale" ? Color.blue : breathPhase == "Hold" ? Color.green : Color.orange, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .frame(width: 200, height: 200)
                    .animation(.linear(duration: .infinity), value: progress)
                
                if !sessionComplete {
                    Text(breathPhase)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(breathPhase == "Inhale" ? .blue : breathPhase == "Hold" ? .green : .orange)
                } else {
                    Text("2:00")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
            }
            
            Spacer()
            
            Button(action: toggleBreathing) {
                Text(isExercising ? "Stop \(breathPhase)" : "Start Exercise")
                    .font(.title2)
                    .padding()
                    .foregroundColor(.white)
                    .background(isExercising ? (breathPhase == "Inhale" ? Color.blue : breathPhase == "Hold" ? Color.green : Color.orange) : Color.green)
                    .cornerRadius(8)
            }
            .disabled(sessionComplete) // Disable button after session completion
        }
        .padding()
    }

    private func startBreathing() {
        totalElapsedTime = 0.0
        sessionComplete = false
        breathDurations.removeAll()
        inhaleDurations.removeAll()
        exhaleDurations.removeAll()
        isExercising = true
        startTimer()
        startInhale()
    }

    private func startInhale() {
        breathPhase = "Inhale"
        progress = 0.0
        currentPhaseStartTime = Date()
        inhaleTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            totalElapsedTime += 1
            updateProgress(for: "Inhale")
        }
    }
    
    private func startHold() {
        breathPhase = "Hold"
        progress = 0.0
        currentPhaseStartTime = Date()
        holdTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            totalElapsedTime += 1
            updateProgress(for: "Hold")
        }
    }
    
    private func startExhale() {
        breathPhase = "Exhale"
        progress = 0.0
        currentPhaseStartTime = Date()
        exhaleTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            totalElapsedTime += 1
            updateProgress(for: "Exhale")
        }
    }
    
    private func updateProgress(for phase: String) {
        if phase == "Inhale" {
            progress += 0.1
        } else if phase == "Hold" {
            progress += 0.1
        } else {
            progress += 0.1
        }
        
        if progress >= 1.0 {
            progress = 0.0
           
        }
    }
    
    private func advancePhase() {
        recordPhaseDuration()
        if breathPhase == "Inhale" {
            inhaleTimer?.invalidate()
            startHold()
        } else if breathPhase == "Hold" {
            holdTimer?.invalidate()
            startExhale()
        } else {
            exhaleTimer?.invalidate()
            if totalTimer == nil {
                isExercising = false
                sessionComplete = true
            } else {
                startInhale()
            }
           // sessionComplete = true
        }
    }

    
    
    private func recordPhaseDuration() {
        guard let startTime = currentPhaseStartTime else { return }
        let duration = Date().timeIntervalSince(startTime)
        
        if breathPhase == "Inhale" {
            inhaleDurations.append(duration)
        } else if breathPhase == "Exhale" {
            exhaleDurations.append(duration)
            let fullBreathDuration = (inhaleDurations.last ?? 0.0) + duration
            breathDurations.append(fullBreathDuration)
        }
    }

    private func toggleBreathing() {
        if isExercising {
            stopCurrentPhase()
        } else {
            
            startBreathing()
        }
    }
    
    private func startTimer() {
        totalTimer = Timer.scheduledTimer(withTimeInterval: totalSessionDuration, repeats: true) { _ in
            totalTimer?.invalidate()
            totalTimer = nil
        }
    }

    private func stopCurrentPhase() {
        if breathPhase == "Inhale" {
            inhaleTimer?.invalidate()
        } else if breathPhase == "Hold" {
            holdTimer?.invalidate()
        } else {
            exhaleTimer?.invalidate()
        }
        advancePhase() // Automatically advance to the next phase
    }

    // Stats Calculations
    private func calculateBreathScore() -> Int {
        let consistency = 100 - Int((longestBreath() - shortestBreath()) * 10)
        return max(consistency, 0)
    }
    
    private func averageBreathsPerMinute() -> Double {
        let totalBreaths = Double(breathDurations.count)
        return (totalBreaths / totalElapsedTime) * 60.0
    }
    
    private func averageInhaleTime() -> Double {
        return inhaleDurations.isEmpty ? 0.0 : inhaleDurations.reduce(0.0, +) / Double(inhaleDurations.count)
    }
    
    private func averageExhaleTime() -> Double {
        return exhaleDurations.isEmpty ? 0.0 : exhaleDurations.reduce(0.0, +) / Double(exhaleDurations.count)
    }
    
    private func longestBreath() -> Double {
        return breathDurations.max() ?? 0.0
    }
    
    private func shortestBreath() -> Double {
        return breathDurations.min() ?? 0.0
    }
}




#Preview {
    PRBellyBreathingView()
}
