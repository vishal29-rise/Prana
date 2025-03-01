//
//  PREnergyHigh.swift
//  Prana21
//
//  Created by Vishal Thakur on 09/02/25.
//

import SwiftUI
import AVFoundation
import _AVKit_SwiftUI

struct PREnergyHigh: View {
    //MARK: - Environment Variables
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    @State private var auraPlayer = AVPlayer(url: Bundle.main.url(forResource: "screen16", withExtension: "mp4")!)
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
            VideoPlayer(player: auraPlayer)
                .aspectRatio(2160/3840,contentMode: .fill)
                .ignoresSafeArea(.all)
                .onAppear {
                    
                    auraPlayer.play()
                    //observeVideoCompletion()
                }
            Color(hex: "#0D0960").opacity(0.30).ignoresSafeArea()
            VStack {
                VStack {
                    Text(AppTexts.findingYourIdeal)
                        .font(.system(size: 24.0,weight: .semibold,design: .rounded))
                        .foregroundColor(AppTheme.primaryTextColor)
                    
                    Text(AppTexts.breathingRythm)
                        .font(.system(size: 36.0,weight: .semibold,design: .rounded))
                        .foregroundColor(AppTheme.primaryCTABackgroundColor)
                    
                }
                .padding(.top,20)
                Spacer()
                VStack {
                    Text(AppTexts.keepingStress)
                        .font(.system(size: 24.0,weight: .semibold,design: .rounded))
                        .foregroundColor(AppTheme.primaryTextColor)
                    
                    Text(AppTexts.energyHigh)
                        .font(.system(size: 36.0,weight: .semibold,design: .rounded))
                        .foregroundColor(AppTheme.primaryCTABackgroundColor)
                    
                    
                }
                
                NavigationLink(destination: {
                    BreathingExerciseView()
                }, label: {
                    Text(AppActions.go)
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
        .toolbar(content: {
                ToolbarItem( placement: .topBarLeading,content: {
                    HStack(content: {
                        btnBack
                        
                    })
                })
            ToolbarItem( placement: .topBarTrailing,content: {
                HStack(content: {
                    btnMute
                })
            })
                
            })
    }
}

#Preview {
    PREnergyHigh()
}
