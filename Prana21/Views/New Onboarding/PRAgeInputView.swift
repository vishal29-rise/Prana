//
//  PRNervesView.swift
//  Prana21
//
//  Created by Vishal Thakur on 26/01/25.
//

import SwiftUI
import _AVKit_SwiftUI

struct PRAgeInputView: View {
    //MARK: - Environment Variables
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    
    @State private var auraPlayer = AVPlayer(url: Bundle.main.url(forResource: "Age", withExtension: "mp4")!)
    @State private var name: String = ""
    @State private var age: String = "25-35"
    @State private var isItemsVisible = false
    
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
                .aspectRatio(isItemsVisible ? 1170/2300 : 1170/2532,contentMode: .fill)
                .ignoresSafeArea(.all)
                .onAppear {
                    
                    auraPlayer.play()
                    observeVideoCompletion()
                }
                .allowsHitTesting(false)
            
            VStack {
                VStack {
                   
                        Text(AppTexts.iAm)
                            .font(.system(size: 24.0,weight: .semibold,design: .rounded))
                            .foregroundColor(AppTheme.primaryTextColor)
                        
                        Text(AppTexts.oldMonk)
                            .font(.system(size: 36.0,weight: .semibold,design: .rounded))
                            .foregroundColor(AppTheme.primaryCTABackgroundColor)
                  
                }
                .padding(.top,40)
                Spacer()
                
                VStack {
                    if isItemsVisible{
                        
                        Text(AppTexts.howOld)
                            .font(.system(size: 24.0,weight: .semibold,design: .rounded))
                            .foregroundColor(AppTheme.primaryTextColor)
                            .padding(.zero)
                            .padding(.bottom,20)
                        
                        PRAgeSelectionView(selectedRange: $age)
                            .padding(.horizontal,60)
                            .padding(.bottom,20)
                    }
                    
                }
                if isItemsVisible {
                    NavigationLink(destination: {
                        PRGenderSelectionView()
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
                    
                    .padding(.bottom, 70)
                    .padding(.horizontal,40)
                }
            }
            
            
        }
        .navigationBarBackButtonHidden()
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
    private func observeVideoCompletion() {
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: auraPlayer.currentItem, queue: .main) { _ in
                withAnimation(.easeInOut(duration: 0.8)) {
                    isItemsVisible = true
                    
                    BackgroundAudioManager.shared.play()
                    
                }
            }
        }
}

#Preview {
    PRAgeInputView()
}
