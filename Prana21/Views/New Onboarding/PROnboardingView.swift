//
//  PROnboardingView.swift
//  Prana21
//
//  Created by Vishal Thakur on 21/01/25.
//

import SwiftUI

struct PROnboardingView: View {
    
    //MARK: - Environment Variables
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    
    @State private var currentBackground: String = Constants.AppImages.introBackgrounds.first ?? ""
    
    @State private var currentOnboardingStatus: Onboarding = .what
    
    @State private var ctaTitle : String = AppActions.ready
    
    @State private var caption1: String = AppTexts.discover
    @State private var caption2: String? = nil
    @State private var caption3: String = AppTexts.superpower
    @State private var caption4: String? = nil
    @State private var caption5: String? = nil
    
    // Navigation state
    @State private var navigateToNextView: Bool = false
    
    
    var body: some View {
            ZStack {
                Image(currentBackground)
                    .resizable()
                    .ignoresSafeArea(edges: .all)
                    .transition(.asymmetric(
                        insertion: .scale(scale: 1.5),
                        removal: .scale(scale: 0.5)
                    ))
                    .id(currentBackground) // Ensure the view is uniquely identified
                
                
                VStack(alignment: .center) {
                    
                    Image(Constants.AppImages.stamp)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100,height: 100)
                        .padding(.top, 25)
                        .padding(.bottom,20)
                    
                    
                    VStack {
                        Group {
                            
                            Text(caption1)
                                .font(.system(size: 24.0,weight: .semibold,design: .rounded))
                                .foregroundColor(AppTheme.primaryTextColor)
                            if let caption2 {
                                Text(caption2)
                                    .font(.system(size: 24.0,weight: .semibold,design: .rounded))
                                    .foregroundColor(AppTheme.primaryTextColor)
                            }
                            Text(caption3)
                                .font(.system(size: 36.0,weight: .semibold,design: .rounded))
                                .foregroundColor(AppTheme.primaryCTABackgroundColor)
                            
                        }
                        
                    }
                    
                    Spacer()
                    if let caption4,let caption5 {
                        VStack {
                            Text(caption4)
                                .font(.system(size: 24.0,weight: .semibold,design: .rounded))
                                .foregroundColor(AppTheme.primaryTextColor)
                            Text(caption5)
                                .font(.system(size: 36.0,weight: .semibold,design: .rounded))
                                .foregroundColor(AppTheme.primaryCTABackgroundColor)
                        }
                        .foregroundColor(AppTheme.primaryTextColor)
                        .padding(.bottom, 20)
                    }
                    
                    Button(action: {
                        proceedOnboarding()
                    }, label: {
                        Text(ctaTitle)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 15)
                            .font(.custom(Constants.AppFonts.inter18SemiBold, size: 20.0))
                            .foregroundColor(ThemeManager.shared.theme.primaryCTATextColor)
                    })
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(
                        Capsule()
                            .fill(ThemeManager.shared.theme.primaryCTABackgroundColor)
                    )
                    .padding(.bottom, 20)
                    .padding(.horizontal,40)
                    
                }
            }
            .navigationBarBackButtonHidden()
            .modifier(CustomToolbarModifier())
            .navigationDestination(isPresented: $navigateToNextView) {
                // New View when onboarding is complete
                PRGetStartedView()
            }
            
        
    }
    private func goBack() {
        switch currentOnboardingStatus {
        case .what:
            currentOnboardingStatus = .what
            presentationMode.wrappedValue.dismiss()
        case .why:
            currentOnboardingStatus = .what
        case .really:
            currentOnboardingStatus = .why
        case .shocked:
            currentOnboardingStatus = .really
        case .whyAgain:
            currentOnboardingStatus = .shocked
        case .yes:
            currentOnboardingStatus = .whyAgain
            navigateToNextView = false
        case .getStarted:
            currentOnboardingStatus = .whyAgain
            navigateToNextView = false
            //currentOnboardingStatus = .getStarted
            //navigateToNextView = true
        }
        setOnboarding()
    }
    private func proceedOnboarding() {
        switch currentOnboardingStatus {
        case .what:
            currentOnboardingStatus = .why
        case .why:
            currentOnboardingStatus = .really
        case .really:
            currentOnboardingStatus = .shocked
        case .shocked:
            currentOnboardingStatus = .whyAgain
        case .whyAgain:
            currentOnboardingStatus = .yes
        case .yes:
            currentOnboardingStatus = .getStarted
            navigateToNextView = true
        case .getStarted: break
            //currentOnboardingStatus = .getStarted
            //navigateToNextView = true
        }
        setOnboarding()
    }
    
    private func setOnboarding() {
        withAnimation{
            switch currentOnboardingStatus {
            case .what:
                ctaTitle = AppActions.what
                caption1 = AppTexts.discover
                caption2 = nil
                caption3 = AppTexts.superpower
                caption4 = nil
                caption5 = nil
                currentBackground = Constants.AppImages.introBackgrounds[0]
            case .why:
                ctaTitle = AppActions.how
                caption1 = AppTexts.tortoise
                caption2 = nil
                caption3 = AppTexts.fourTimesAMinute
                caption4 = AppTexts.andLivesFor
                caption5 = AppTexts.threeHundredYears
                currentBackground = Constants.AppImages.introBackgrounds[1]
            case .really:
                ctaTitle = AppActions.really
                caption1 = AppTexts.justCorrect
                caption2 = nil
                caption3 = AppTexts.breathing
                caption4 = AppTexts.yourBreath
                caption5 = AppTexts.superpower
                currentBackground = Constants.AppImages.introBackgrounds[2]
            case .shocked:
                ctaTitle = AppActions.next
                caption1 = AppTexts.weBreatheEveryDay
                caption2 = AppTexts.mostOfUs
                caption3 = AppTexts.wrong
                caption4 = nil
                caption5 = nil
                currentBackground = Constants.AppImages.introBackgrounds[3]
            case .whyAgain:
                ctaTitle = AppActions.why
                caption1 = AppTexts.everWonderedWhy
                caption2 = AppTexts.whyMonk
                caption3 = AppTexts.calm
                caption4 = nil
                caption5 = nil
                currentBackground = Constants.AppImages.introBackgrounds[4]
            case .yes:
                ctaTitle = AppActions.yes
                caption1 = AppTexts.allInBreaths
                caption2 = AppTexts.letsLearnTheirSecrets
                caption3 = AppTexts.secrets
                caption4 = nil
                caption5 = nil
                currentBackground = Constants.AppImages.introBackgrounds[5]
            case .getStarted:
                break
            }
        }
    }
}

#Preview {
    PROnboardingView()
}
