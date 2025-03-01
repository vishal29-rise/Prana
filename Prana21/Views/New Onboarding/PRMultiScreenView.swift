//
//  PRMultiScreenView.swift
//  Prana21
//
//  Created by Vishal Thakur on 28/02/25.
//

import SwiftUI
import AVFoundation
import _AVKit_SwiftUI

enum ScreenType {
   case screen1, screen2, screen3, screen4, screen5, screen6, screen7
}

struct PRMultiScreenView: View {
    //MARK: - Environment Variables
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    
    @State private var title1: String?
    @State private var title2: String?
    @State private var title3: String?
    @State private var title4: String?
    @State private var title5: String?
    @State private var title6: String?
    @State private var CTA: String
    var screenType: ScreenType
    
    
    init(type: ScreenType) {
        
        switch type {
        case .screen1:
            title1 = AppTexts.mindfulBreaths
            title2 = AppTexts.anytime
            title4 = AppTexts.shiftsEnergy
            title5 = AppTexts.wellbeing
            self.auraPlayer = AVPlayer(url: Bundle.main.url(forResource: "screen1", withExtension: "mp4")!)
            CTA = AppActions.go
            screenType = .screen1
        case .screen2:
            title1 = AppTexts.hack
            title2 = AppTexts.keepStressAtBay
            title4 = AppTexts.especiallyInLifes
            title5 = AppTexts.inBetweenMoments
            self.auraPlayer = AVPlayer(url: Bundle.main.url(forResource: "screen2", withExtension: "mp4")!)
            CTA = AppActions.join
            screenType = .screen2
        case .screen3:
            title1 = AppTexts.buildingHabits
            title2 = AppTexts.science
            title4 = AppTexts.spareMoment
            title5 = AppTexts.opportunity
            self.auraPlayer = AVPlayer(url: Bundle.main.url(forResource: "screen3", withExtension: "mp4")!)
            CTA = AppActions.knowHow
            screenType = .screen3
        case .screen4:
            title1 = AppTexts.worldFirst
            title2 = AppTexts.scienceBased
            title4 = AppTexts.turningSpareMoments
            title5 = AppTexts.toMindfulBreaths
            self.auraPlayer = AVPlayer(url: Bundle.main.url(forResource: "screen4", withExtension: "mp4")!)
            CTA = AppActions.iAmIn
            screenType = .screen4
        case .screen5:
            title1 = AppTexts.jusReset
            title2 = AppTexts.sevenDays
            title4 = AppTexts.fiveBreaths
            title5 = AppTexts.threeTimesDay
            self.auraPlayer = AVPlayer(url: Bundle.main.url(forResource: "screen5", withExtension: "mp4")!)
            CTA = AppActions.iAmIn
            screenType = .screen5
        case .screen6:
            title1 = AppTexts.guideYou
            title2 = AppTexts.breathingLifeStyle
            title4 = AppTexts.keepYouOnTrack
            title5 = AppTexts.oneBreathTime
            self.auraPlayer = AVPlayer(url: Bundle.main.url(forResource: "screen6", withExtension: "mp4")!)
            CTA = AppActions.letsDoIt
            screenType = .screen6
        case .screen7:
            title1 = AppTexts.threeXChances
            title2 = AppTexts.habits
            title4 = AppTexts.enableNotifications
            title5 = AppTexts.freshAir
            self.auraPlayer = AVPlayer(url: Bundle.main.url(forResource: "screen7", withExtension: "mp4")!)
            CTA = AppActions.enableNotifications
            screenType = .screen7
        }
        
    }
    
    @State private var auraPlayer: AVPlayer
    //back button
    var btnBack : some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(Constants.AppImages.backIcon)
                .padding([.top],10)
        }
    }
    var btnMute : some View {
        Button(action: {
            BackgroundAudioManager.shared.pause()
        }) {
            Image(systemName: "speaker.fill")
                .renderingMode(.template)
                .foregroundStyle(AppTheme.primaryCTABackgroundColor)
                .padding([.top],10)
        }
    }
    
    var body: some View {
        ZStack {
//            Image(Constants.AppImages.getStarted_02)
//                .resizable()
//                .ignoresSafeArea(edges: .all)
            VideoPlayer(player: auraPlayer)
                
                
                .aspectRatio(2160/3840,contentMode: .fill)
                .ignoresSafeArea(.all)
            /*frame(width: UIScreen.main.bounds.width, height: 200)*/
                .onAppear {
                    auraPlayer.play()
                    //observeVideoCompletion()
                }
            Color(hex: "#0D0960").opacity(0.40).ignoresSafeArea()
            VStack {
                VStack {
                    if let title1 {
                        Text(title1)
                            .font(.system(size: 24.0,weight: .semibold,design: .rounded))
                            .foregroundColor(AppTheme.primaryTextColor)
                    }
                    if let title2 {
                        Text(title2)
                            .font(.system(size: 36.0,weight: .semibold,design: .rounded))
                            .foregroundColor(AppTheme.primaryCTABackgroundColor)
                    }
                    if let title3 {
                        Text(title3)
                            .font(.system(size: 24.0,weight: .semibold,design: .rounded))
                            .foregroundColor(AppTheme.primaryTextColor)
                    }
                }
                .padding(.top,20)
                Spacer()
                VStack {
                    if let title4{
                        Text(title4)
                            .font(.system(size: 24.0,weight: .semibold,design: .rounded))
                            .foregroundColor(AppTheme.primaryTextColor)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                    
                    if let title5{
                        Text(title5)
                            .font(.system(size: 36.0,weight: .semibold,design: .rounded))
                            .foregroundColor(AppTheme.primaryCTABackgroundColor)
                            .multilineTextAlignment(.center)
                    }
                    
                    if let title6 {
                        Text(title6)
                            .font(.system(size: 24.0,weight: .semibold,design: .rounded))
                            .foregroundColor(AppTheme.primaryTextColor)
                    }
                    
                }
                
                NavigationLink(destination: {
                    switch screenType {
                    case .screen1:
                        PRMultiScreenView(type: .screen2)
                    case .screen2:
                        PRWhyBreathingMatters()
                    case .screen3:
                        PRMultiScreenView(type: .screen4)
                    case .screen4:
                        PRMultiScreenView(type: .screen5)
                    case .screen5:
                        PRMultiScreenView(type: .screen6)
                    case .screen6:
                        PRMultiScreenView(type: .screen7)
                    case .screen7:
                        PRMultiScreenView(type: .screen7)
                    }
                }, label: {
                    Text(CTA)
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
                    
                )
                .navigationBarBackButtonHidden()
                .padding(.bottom, 20)
                .padding(.horizontal,40)
            }
            
            
        }
        .modifier(CustomToolbarModifier())
    }
}

#Preview {
    PRMultiScreenView(type: .screen1)
}
