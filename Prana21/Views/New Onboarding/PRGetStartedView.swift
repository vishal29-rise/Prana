//
//  PRGetStartedView.swift
//  Prana21
//
//  Created by Vishal Thakur on 25/01/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct PRGetStartedView: View {
    //MARK: - Environment Variables
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var audioPlayerManager = AudioPlayerManager()
    
    @State private var auraPlayer = AVPlayer(url: Bundle.main.url(forResource: "Welcome", withExtension: "mp4")!)
    @State private var isButtonVisible = false  // Tracks button visibility
    
    
    
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
                        VStack{
                            
                            Text(AppTexts.welcomeTo)
                                .padding(0)
                            Image(Constants.AppImages.written_logo)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 40)
                                .frame(maxWidth: 120)
                                .padding(0)
                        }
                        .foregroundColor(.white)
                        .padding(.top,80)
                        Spacer()
                        if isButtonVisible {
                            NavigationLink(destination: {
                                PRNameInputView()
                            }, label: {
                                Text(AppActions.getStarted)
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
                    isButtonVisible = true
                    
                    BackgroundAudioManager.shared.play()
                    
                }
            }
        }
}

#Preview {
    PRGetStartedView()
}
import AVFoundation
import _AVKit_SwiftUI
class AudioPlayerManager: ObservableObject {
    var audioPlayer: AVAudioPlayer?

    func playSound(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            } catch {
                print("Error playing audio: \(error.localizedDescription)")
            }
        } else {
            print("Audio file not found")
        }
    }

    func stopSound() {
        audioPlayer?.stop()
    }
}
