//
//  PRWhyBreathingMatters.swift
//  Prana21
//
//  Created by Vishal Thakur on 26/01/25.
//

import SwiftUI
import _AVKit_SwiftUI

struct PRWhyBreathingMatters: View {
    //MARK: - Environment Variables
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    
    @State private var auraPlayer = AVPlayer(url: Bundle.main.url(forResource: "screen9", withExtension: "mp4")!)
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
            Color(hex: "#0D0960").opacity(0.25).ignoresSafeArea()
            VStack {
                VStack {
                    Text(AppTexts.whyBreathing)
                        .font(.system(size: 24.0,weight: .semibold,design: .rounded))
                        .foregroundColor(AppTheme.primaryTextColor)
                    
                    Text(AppTexts.matters)
                        .font(.system(size: 36.0,weight: .semibold,design: .rounded))
                        .foregroundColor(AppTheme.primaryCTABackgroundColor)
                    
                }
                .padding(.top,20)
                Spacer()
                VStack {
                    Text(AppTexts.itsHow)
                        .font(.system(size: 24.0,weight: .semibold,design: .rounded))
                        .foregroundColor(AppTheme.primaryTextColor)
                    
                    Text(AppTexts.brainBody)
                        .font(.system(size: 36.0,weight: .semibold,design: .rounded))
                        .foregroundColor(AppTheme.primaryCTABackgroundColor)
                    
                    Text(AppTexts.communicate)
                        .font(.system(size: 24.0,weight: .semibold,design: .rounded))
                        .foregroundColor(AppTheme.primaryTextColor)
                    
                }
                
                NavigationLink(destination: {
                    PRRelaxEnergyView()
                }, label: {
                    Text(AppActions.how)
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
    PRWhyBreathingMatters()
}
