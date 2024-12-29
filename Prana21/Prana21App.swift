//
//  Prana21App.swift
//  Prana21
//
//  Created by Vishal Thakur on 28/10/24.
//

import SwiftUI

@main
struct Prana21App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            PRLandingView()
            
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.registerForRemoteNotifications()
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Device token: \(token)")
        // Send token to your server
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error.localizedDescription)")
    }
}


import SwiftUI

struct BreathingTechnique {
    let name: String
    let description: String
    let timing: [Int]?
}

class BreathingTechniqueRecommender {
    func recommend(breathRate: Double) -> BreathingTechnique {
        switch breathRate {
        case ..<8.0:
            return BreathingTechnique(
                name: "Stimulating Breath",
                description: "Increase energy and focus with rapid breathing exercises.",
                timing: nil
            )
        case 8.0...20.0:
            return BreathingTechnique(
                name: "Box Breathing",
                description: "Breathe in for 4 seconds, hold for 4 seconds, exhale for 4 seconds, and hold for 4 seconds.",
                timing: [4, 4, 4, 4]
            )
        default:
            return BreathingTechnique(
                name: "4-7-8 Breathing",
                description: "Breathe in for 4 seconds, hold for 7 seconds, and exhale for 8 seconds to reduce anxiety.",
                timing: [4, 7, 8]
            )
        }
    }
}

struct BreathRateCaptureView: View {
    @State private var breathCount = 0
    @State private var timerRunning = false
    @State private var elapsedTime = 0.0
    @State private var breathRate: Double? = nil
    
    @State private var startTime: Date? = nil
    @State private var timer: Timer? = nil
    
    @State private var recommendedTechnique: BreathingTechnique? = nil
    
    let recommender = BreathingTechniqueRecommender()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Breath Rate Monitor")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("Tap to count each inhale or exhale.")
                .font(.headline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Text("\(breathCount) Breaths")
                .font(.largeTitle)
                .foregroundColor(.blue)
            
            if let rate = breathRate {
                Text("Breath Rate: \(String(format: "%.1f", rate)) breaths/min")
                    .font(.headline)
                    .foregroundColor(.green)
            }
            
            if let technique = recommendedTechnique {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Recommended Technique:")
                        .font(.headline)
                        .foregroundColor(.purple)
                    Text(technique.name)
                        .font(.title2)
                        .foregroundColor(.blue)
                    Text(technique.description)
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }
                .padding()
                .background(Color.yellow.opacity(0.2))
                .cornerRadius(10)
            }
            
            Spacer()
            
            Button(action: handleTap) {
                Text(timerRunning ? "Tap for Inhale/Exhale" : "Start")
                    .font(.title2)
                    .padding()
                    .foregroundColor(.white)
                    .background(timerRunning ? Color.blue : Color.green)
                    .cornerRadius(8)
            }
            
            Button(action: reset) {
                Text("Reset")
                    .font(.title2)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(8)
            }
            .opacity(timerRunning || breathCount > 0 ? 1 : 0.5)
            .disabled(!(timerRunning || breathCount > 0))
            
            Spacer()
        }
        .padding()
    }
    
    private func handleTap() {
        if !timerRunning {
            // Start timer
            startTime = Date()
            timerRunning = true
            breathCount = 0
            elapsedTime = 0.0
            breathRate = nil
            recommendedTechnique = nil
        } else {
            // Increment breath count
            breathCount += 1
            if let startTime = startTime {
                elapsedTime = Date().timeIntervalSince(startTime)
                breathRate = (Double(breathCount) / elapsedTime) * 60.0
                if let rate = breathRate {
                    recommendedTechnique = recommender.recommend(breathRate: rate)
                }
            }
        }
    }
    
    private func reset() {
        breathCount = 0
        timerRunning = false
        elapsedTime = 0.0
        breathRate = nil
        timer?.invalidate()
        startTime = nil
        recommendedTechnique = nil
    }
}
