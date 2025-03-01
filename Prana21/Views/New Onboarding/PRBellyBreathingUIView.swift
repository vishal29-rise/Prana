//
//  PRBellyBreathingView.swift
//  Prana21
//
//  Created by Vishal Thakur on 01/03/25.
//

import SwiftUI

struct PRBellyBreathingUIView: View {
    //MARK: - Environment Variables
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    
    @State private var sessionStartTime: Date?
    @State private var sessionDuration: TimeInterval = 120
    
    
    
    @State private var breathCount = 5
    @State private var currentStep = 5
    @State private var isBreathing = false
    @State private var buttonText: String = "Tap"
    
    
    @State private var isInhaling = false
    @State private var activeIndex = -1
    @State private var isAnimating = false
   
    @State private var breathScale: CGFloat = 1.0
    @State private var inhaleTimes: [TimeInterval] = []
    @State private var exhaleTimes: [TimeInterval] = []
    @State private var lastBreathStartTime = Date()
    @State private var exerciseCompleted: Bool = true
    @State private var animateForward: Bool = false
    
    let totalSteps = 5
    let selectedColor: Color = Color(hex: "#90BFFF")
    
    var totalDuration: TimeInterval {
        return (inhaleTimes + exhaleTimes).reduce(0, +)
    }

    var breathDurations: [TimeInterval] {
        return zip(inhaleTimes, exhaleTimes).map { $0 + $1 }
    }
    
    
    var body: some View {
        ZStack {
            Image(Constants.AppImages.getStarted)
                .resizable()
                .ignoresSafeArea(edges: .all)
            VStack {
                
                VStack {
                    Text(AppTexts.letsPractice)
                        .font(.system(size: 24.0,weight: .semibold,design: .rounded))
                        .foregroundColor(AppTheme.primaryTextColor)
                    
                    Text(AppTexts.together)
                        .font(.system(size: 36.0,weight: .semibold,design: .rounded))
                        .foregroundColor(AppTheme.primaryCTABackgroundColor)
                    
                }
                .padding(.top,20)
                Spacer()
                
                VStack {
                    ZStack{
                        PRAuraView(hideLogo: true, isVisible: $animateForward)
                            
//                        Button(action: {
//                            startBreathing()
//                        }, label: {
                            Text(buttonText)
                                .font(.system(size: 36.0,weight: .semibold,design: .rounded))
                                .foregroundColor(AppTheme.primaryTextColor)
                       // })
                        .frame(minWidth: 100,minHeight: 100)
                        
                    }
                    .onTapGesture {
                        startBreathing()
                    }
                   
                    
                    
                    .padding(.bottom, 80)
                    
                    
                    Text(isBreathing ? isInhaling ? "Inhaling..." : "Exhaling..." : "")
                        .foregroundColor(.white)
                    VStack {
                        Text(AppTexts.tapEveryTIme)
                            .font(.system(size: 24.0,weight: .semibold,design: .rounded))
                            .foregroundColor(AppTheme.primaryTextColor)
                        
                        Text(AppTexts.inahaleExhale)
                            .font(.system(size: 36.0,weight: .semibold,design: .rounded))
                            .foregroundColor(AppTheme.primaryCTABackgroundColor)
                        
                    }
                    .padding(.top,20)                }
                .padding()
                
                
                // Retake Button
                Button(action: {
                    resetBreathing()
                }) {
                    Text("Retake")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(ThemeManager.shared.theme.primaryCTABackgroundColor)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(ThemeManager.shared.theme.primaryCTABackgroundColor, lineWidth: 1))
                }
                .padding(.top)
                .padding(.bottom,20)
                
                
                
               
                
 
                NavigationLink(destination: {
                    if buttonText == "Finished" {
                        //PRScoreView(totalDuration: totalDuration, durations: breathDurations)
                        PRMoodView(type: .after,totalDuration: totalDuration,durations: breathDurations)
                    }
                }, label: {
                    Text("Submit")
                        .padding(.horizontal, 40)
                        .padding(.vertical, 15)
                        .font(.custom(Constants.AppFonts.inter18SemiBold, size: 20.0))
                        .foregroundColor(ThemeManager.shared.theme.primaryCTATextColor)
                        
                        .frame(maxWidth: .infinity, alignment: .center)
                })
                .frame(maxWidth: .infinity, alignment: .center)
                .background(
                    Capsule()
                        .fill(ThemeManager.shared.theme.primaryCTABackgroundColor)
                        .opacity(buttonText == "Finished" ? 1.0 : 0.5)
                )
                
                .padding(.horizontal)
            }
            .navigationBarBackButtonHidden()
            .padding(.vertical)
        }
        .modifier(CustomToolbarModifier())
    }
    
    func startBreathing() {
        let currentTime = Date()
        
        // Start session if it's the first tap
        if sessionStartTime == nil {
            sessionStartTime = currentTime
            isBreathing = true
            exerciseCompleted = false
            buttonText = "    "
        }
        
        // Check if 2 minutes have passed
        if let startTime = sessionStartTime, currentTime.timeIntervalSince(startTime) >= sessionDuration {
            isBreathing = false
            buttonText = "Finished"
            return
        }
        
        // Record breath duration
        let duration = currentTime.timeIntervalSince(lastBreathStartTime)
        lastBreathStartTime = currentTime

        // Toggle inhale/exhale
        isInhaling.toggle()
        
        if isInhaling {
            inhaleTimes.append(duration)
            animateForward = true
            //buttonText = "Exhale"
        } else {
            exhaleTimes.append(duration)
            animateForward = false
           // buttonText = "Inhale"
        }
    }

    
    func resetBreathing() {
        activeIndex = -1
        isBreathing = false
        isInhaling = true
        buttonText = "Tap"
        exerciseCompleted = false
        animateForward = false
        inhaleTimes.removeAll()
        exhaleTimes.removeAll()
        breathScale = 1.0
        lastBreathStartTime = Date()
        sessionStartTime = nil // Reset session start time
    }

}

#Preview {
    PRBellyBreathingUIView()
}
