//
//  PRBellyBreathingIntroView.swift
//  Prana21
//
//  Created by Vishal Thakur on 22/02/25.
//

import SwiftUI
import AVFoundation
import _AVKit_SwiftUI

struct PRBellyBreathingIntroView: View {
    //MARK: - Environment Variables
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var audioPlayerManager = AudioPlayerManager()
    
    @State private var auraPlayer = AVPlayer(url: Bundle.main.url(forResource: "BellyBreathingIntro", withExtension: "mp4")!)
    @State private var isButtonVisible = false  // Tracks button visibility
    @State private var showPlaceholder: Bool = false
    
    
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
    @State var isAnimating: Bool = true
    
    var body: some View {
        ZStack {
            Image(Constants.AppImages.getStarted)
                .resizable()
                .ignoresSafeArea(edges: .all)
                
         
                ZStack {
                    if showPlaceholder {
                        Image(Constants.AppImages.turtle)
                            .resizable()
                            .frame(width: 250,height: 250)
                    }
                    VideoPlayer(player: auraPlayer)
                        
                        .aspectRatio(1956/4236,contentMode: .fill)
                        .ignoresSafeArea()
                    /*frame(width: UIScreen.main.bounds.width, height: 200)*/
                        .onAppear {
                            
                            auraPlayer.play()
                            observeVideoCompletion()
                        }
                        .allowsHitTesting(false)
                       // .padding(.top,25)
                    VStack {
                        VStack {
                            Text(AppTexts.letsPractice)
                                .font(.system(size: 24.0,weight: .semibold,design: .rounded))
                                .foregroundColor(AppTheme.primaryTextColor)
                            
                            Text(AppTexts.correctBreathing)
                                .font(.system(size: 36.0,weight: .semibold,design: .rounded))
                                .foregroundColor(AppTheme.primaryCTABackgroundColor)
                            
                        }
                        .padding(.top,80)
                        Spacer()
                        if isButtonVisible {
                            NavigationLink(destination: {
                                PRMoodView(type: .before)
                            }, label: {
                                Text(AppActions.next)
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
                            
                            .padding(.bottom,80)
                            .padding(.horizontal,40)
                        }
                    }
                    
                }
                
               
                
                
                .navigationBarBackButtonHidden()
               // .padding(.bottom, 20)
               // .padding(.horizontal,40)
            
            //.padding(.top,30)
        }
        .navigationBarBackButtonHidden()
        .modifier(CustomToolbarModifier())
    }
    private func observeVideoCompletion() {
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: auraPlayer.currentItem, queue: .main) { _ in
                withAnimation(.easeInOut(duration: 0.8)) {
                    isButtonVisible = true
                    showPlaceholder = true
                    auraPlayer.seek(to: .zero)
                    BackgroundAudioManager.shared.play()
                    
                }
            }
        }
}

#Preview {
    PRBellyBreathingIntroView()
}
