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




struct BreathRateCaptureView: View {
    @State private var breathCount = 0
    @State private var timerRunning = false
    @State private var elapsedTime = 0.0
    @State private var breathRate: Double? = nil
    
    @State private var startTime: Date? = nil
    @State private var sessionComplete = false
    @State private var isInhale: Bool? = nil // Tracks whether the current action is inhale or exhale
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Breath Rate Monitor")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            if !sessionComplete {
                Text("Tap the button below to count each inhale or exhale.")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                if let isInhale  {
                    Text("Current Status: \(isInhale ? "Inhaling" : "Exhaling")")
                        .font(.title2)
                        .foregroundColor(isInhale ? .blue : .orange)
                        .padding()
                }
                
                Text("\(breathCount) Breaths")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                
                Spacer()
                
                Button(action: handleTap) {
                    Text(isInhale ?? false ? "Exhale" : "Inhale")
                        .font(.title2)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            } else {
                if let rate = breathRate {
                    Text("Your Breath Rate: \(String(format: "%.1f", rate)) breaths/min")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                        .padding()
                }
            }
            
            Spacer()
            
            Button(action: reset) {
                Text("Reset")
                    .font(.title2)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(8)
            }
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
            sessionComplete = false
            isInhale = true // Start with inhale
        } else {
            // Increment breath count
            if let isInhale, !isInhale {
                breathCount += 1
            }
            isInhale?.toggle() // Alternate between inhale and exhale
            
            if breathCount == 10 { // Stop after 10 inhales + 10 exhales
                if let startTime = startTime {
                    elapsedTime = Date().timeIntervalSince(startTime)
                    breathRate = (Double(breathCount) / elapsedTime) * 60.0
                    sessionComplete = true
                    timerRunning = false
                }
            }
        }
    }
    
    private func reset() {
        breathCount = 0
        timerRunning = false
        elapsedTime = 0.0
        breathRate = nil
        sessionComplete = false
        startTime = nil
        isInhale = true // Reset to start with inhale
    }
}
