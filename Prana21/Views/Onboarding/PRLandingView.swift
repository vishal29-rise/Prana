//
//  PRLandingView.swift
//  Prana21
//
//  Created by Vishal Thakur on 05/11/24.
//

import SwiftUI
import UIKit
import AVFoundation
import AVKit

struct PRLandingView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var notificationsEnabled: Bool? = nil
    @State private var showSettingsAlert = false
    
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                ZStack {

                        Image(Constants.AppImages.landing_background)
                            .resizable()
                        
                            .frame(width: geometry.size.width)
                            .ignoresSafeArea()
                            .aspectRatio(contentMode: .fit)
                    VStack {
                        Spacer()
                        
                        // App logo and title, positioned with padding to appear under the tree in the background
                        
                        Image(Constants.AppImages.app_logo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width * 0.5,height: geometry.size.height * 0.2)
                        
                            .padding([.top],ThemeManager.shared.theme.type == .dark ? 0.0 : geometry.size.height * 0.45)
                        
                        Spacer(minLength: 50)
                        
                        // Get Started button with capsule style
                        NavigationLink(destination: {
                            PRSignupView()
                        }, label: {
                            Text(AppActions.getStarted)
                                .padding(.horizontal, 40)
                                .padding(.vertical, 10)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(ThemeManager.shared.theme.primaryCTATextColor)
                        })
                        .background(
                            Capsule()
                                .fill(ThemeManager.shared.theme.primaryCTABackgroundColor)
                        )
                        .padding(.bottom, 40) // Extra bottom padding to adjust distance
                        
                       
                    }
                    .padding([.bottom])
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    
                }
            }
        }
        .onChange(of: colorScheme) { newColorScheme in
                    // Update the theme automatically when system theme changes
                    if newColorScheme == .dark {
                        ThemeManager.shared.setTheme(.dark)
                    } else {
                        ThemeManager.shared.setTheme(.light)
                    }
                }
        .onAppear {
            ThemeManager.shared.autoDetectSystemTheme()
            self.requestNotificationPermissions() { status in
                if !status {
                    showSettingsAlert = true
                }
                
            }
        }
        .alert(isPresented: $showSettingsAlert) {
                    Alert(
                        title: Text("Enable Notifications"),
                        message: Text("Notifications are currently disabled. Please enable them in Settings."),
                        primaryButton: .default(Text("Go to Settings"), action: openSettings),
                        secondaryButton: .cancel()
                    )
                }
        
    }
    
    func requestNotificationPermissions(completionHandler: @escaping (Bool) -> ()) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if let error = error {
                    print("Error requesting permissions: \(error.localizedDescription)")
                    completionHandler(false)
                } else {
                    
                    UNUserNotificationCenter.current().getNotificationSettings { settings in
                               DispatchQueue.main.async {
                                   switch settings.authorizationStatus {
                                   case .authorized, .provisional:
                                       notificationsEnabled = true
                                   case .denied, .notDetermined:
                                       notificationsEnabled = false
                                   case .ephemeral:
                                       notificationsEnabled = false
                                   @unknown default:
                                       notificationsEnabled = false
                                   }
                                   completionHandler(notificationsEnabled ?? false)
                               }
                           }
                }
            }
        }
    private func openSettings() {
            if let settingsURL = URL(string: UIApplication.openSettingsURLString),
               UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }
}

#Preview {
    BreathRateCaptureView()
}

import StoreKit

struct StoreKitView: View {
    var body: some View {
        VStack {
            Text("Enjoying our app?")
                .font(.title)
                .padding()

            Button("Rate Us") {
                requestAppStoreReview()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
    
    func requestAppStoreReview() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}
