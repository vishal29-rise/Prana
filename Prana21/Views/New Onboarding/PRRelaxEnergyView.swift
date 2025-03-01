//
//  PRRelaxEnergyView.swift
//  Prana21
//
//  Created by Vishal Thakur on 26/02/25.
//

import SwiftUI
import AVFoundation
import _AVKit_SwiftUI

struct PRRelaxEnergyView: View {
    //MARK: - Environment Variables
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    
    @State private var auraPlayer = AVPlayer(url: Bundle.main.url(forResource: "screen10", withExtension: "mp4")!)
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
            Color(hex: "#0D0960").opacity(0.35).ignoresSafeArea()
            
            VStack {
                VStack {
                    
                    
                    Text(AppTexts.slowBreathing)
                        .font(.system(size: 36.0,weight: .semibold,design: .rounded))
                        .foregroundColor(AppTheme.primaryCTABackgroundColor)
                    Text(AppTexts.lowCortisol)
                        .font(.system(size: 24.0,weight: .semibold,design: .rounded))
                        .foregroundColor(AppTheme.primaryTextColor)
                    Image(Constants.AppImages.arrowsDown)
                }
                .padding(.vertical,20)
                Spacer()
                VStack{
                    Image(Constants.AppImages.relaxArrowDown).padding(.bottom, 20)
                    
                    VStack {
                        Text(AppTexts.balancingTheTwo)
                            .font(.system(size: 22.0,weight: .semibold,design: .rounded))
                            .foregroundColor(AppTheme.primaryTextColor)
                        Text(AppTexts.ultimateLifeHack)
                            .font(.system(size: 22.0,weight: .semibold,design: .rounded))
                            .foregroundColor(AppTheme.primaryCTABackgroundColor)
                    }
                    
                    Image(Constants.AppImages.energyArrowUp).padding(.bottom, 20)
                    
                }
                Spacer()
                VStack {
                    Image(Constants.AppImages.arrowsUp)
                    Text(AppTexts.moreAdrenaline)
                        .font(.system(size: 36.0,weight: .semibold,design: .rounded))
                        .foregroundColor(AppTheme.primaryCTABackgroundColor)
                    
                    Text(AppTexts.fastBreathing)
                        .font(.system(size: 24.0,weight: .semibold,design: .rounded))
                        .foregroundColor(AppTheme.primaryTextColor)
                    
                    
                    
                }
               // .padding(.top,60)
                
                NavigationLink(destination: {
                    BreathingExerciseView()
                }, label: {
                    Text(AppActions.knowMore)
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
    PRRelaxEnergyView()
}
