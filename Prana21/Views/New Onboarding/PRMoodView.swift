//
//  PRMoodView.swift
//  Prana21
//
//  Created by Vishal Thakur on 22/02/25.
//

import SwiftUI

enum MoodScreenType {
    case before, after
}

struct PRMoodView: View {
    //MARK: - Environment Variables
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    
    @State private var selectedId: Int = 1
    
    @State private var emoji1: EmojiData
    @State private var emoji2: EmojiData
    @State private var emoji3: EmojiData
    @State private var emoji4: EmojiData
    @State private var emoji5: EmojiData
    @State private var emoji6: EmojiData
    @State private var headline: String
    @State private var title1: String
    @State private var title2: String
    private var type: MoodScreenType
    private var totalDuration: TimeInterval
    private var durations: [TimeInterval]
    
    init(type: MoodScreenType,totalDuration: TimeInterval = 0.0,durations: [TimeInterval] = []) {
        switch type {
        case .before:
            emoji1  = EmojiData(icon: "emoji1", text: AppTexts.excited)
            emoji2  = EmojiData(icon: "emoji2", text: AppTexts.fatigued)
            emoji3  = EmojiData(icon: "emoji3", text: AppTexts.content)
            emoji4 = EmojiData(icon: "emoji4", text: AppTexts.worried)
            emoji5 = EmojiData(icon: "emoji5", text: AppTexts.frustrated)
            emoji6 = EmojiData(icon: "emoji6", text: AppTexts.overwhelmed)
            headline = AppTexts.firstStep
            title1 = AppTexts.secondstep
            title2 = AppTexts.acceptance
            self.type = .before
        case .after:
            emoji1  = EmojiData(icon: "emoji7", text: AppTexts.excited)
            emoji2  = EmojiData(icon: "emoji8", text: AppTexts.fatigued)
            emoji3  = EmojiData(icon: "emoji9", text: AppTexts.content)
            emoji4 = EmojiData(icon: "emoji10", text: AppTexts.worried)
            emoji5 = EmojiData(icon: "emoji11", text: AppTexts.frustrated)
            emoji6 = EmojiData(icon: "emoji12", text: AppTexts.overwhelmed)
            self.type = .after
            headline = AppTexts.takeAMoment
            title1 = AppTexts.hasYourMoodShifted
            title2 = ""
        }
        self.durations = durations
        self.totalDuration = totalDuration
    }
    
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
            Image("speaker")
                .foregroundColor(AppTheme.primaryCTABackgroundColor)
                .padding([.top],10)
        }
    }
    
    
    var body: some View {
        ZStack {
            Image(Constants.AppImages.getStarted)
                .resizable()
                .ignoresSafeArea(edges: .all)
            VStack {
                VStack {
                    Text(headline)
                        .font(.system(size: 24.0,weight: .semibold,design: .rounded))
                        .foregroundColor(AppTheme.primaryTextColor)
                        .multilineTextAlignment(.center)
                    
                    
                }
                .padding(.top,20)
                .padding(.bottom, 20)
                
                
                VStack{
                    
                    EmojiView(text: emoji1.text, emojiImage: emoji1.icon, isSelected: Binding(
                        get: { selectedId == 1 },
                        set: { if $0 { selectedId = 1 } }
                    ))
                        .onTapGesture {
                            withAnimation {
                                selectedId = 1
                            }
                        }
                   
                    
                    HStack{
                        EmojiView(text: emoji2.text, emojiImage: emoji2.icon, isSelected: Binding(
                            get: { selectedId == 2 },
                            set: { if $0 { selectedId = 2 } }
                        ))
                            .onTapGesture {
                                withAnimation {
                                    selectedId = 2
                                }
                            }
                            .padding(.leading,20)
                        Spacer()
                        EmojiView(text: emoji3.text, emojiImage: emoji3.icon, isSelected: Binding(
                            get: { selectedId == 3 },
                            set: { if $0 { selectedId = 3 } }
                        ))
                            .padding(.trailing,20)
                            .onTapGesture {
                                withAnimation {
                                    selectedId = 3
                                }
                            }
                    }
                    Text("mood ?")
                        .font(.system(size: 26.0,weight: .semibold,design: .rounded))
                        .foregroundColor(AppTheme.primaryCTABackgroundColor)
                    HStack{
                        EmojiView(text: emoji4.text, emojiImage: emoji4.icon, isSelected: Binding(
                            get: { selectedId == 4 },
                            set: { if $0 { selectedId = 4 } }
                        ))
                            .onTapGesture {
                                withAnimation {
                                    selectedId = 4
                                }
                            }
                            .padding(.leading,20)
                        Spacer()
                        EmojiView(text: emoji5.text, emojiImage: emoji5.icon, isSelected: Binding(
                            get: { selectedId == 5 },
                            set: { if $0 { selectedId = 5 } }
                        ))
                            .onTapGesture {
                                withAnimation {
                                    selectedId = 5
                                }
                            }
                            .padding(.trailing,20)
                    }
                    EmojiView(text: emoji6.text, emojiImage: emoji6.icon, isSelected: Binding(
                        get: { selectedId == 6 },
                        set: { if $0 { selectedId = 6 } }
                    ))
                        .onTapGesture {
                            withAnimation {
                                selectedId = 6
                            }
                        }
                    
                }
               
                Spacer()
                VStack {
                    Text(title1)
                        .font(.system(size: 24.0,weight: .semibold,design: .rounded))
                        .foregroundColor(AppTheme.primaryTextColor)
                        .multilineTextAlignment(.center)
                    
                    Text(title2)
                            .font(.system(size: 30.0,weight: .semibold,design: .rounded))
                            .foregroundColor(AppTheme.primaryCTABackgroundColor)
                            .multilineTextAlignment(.center)
                   
                   
                    
                }
                
                NavigationLink(destination: {
                    switch type {
                    case .before:
                        PRBellyBreathingUIView()
                    case .after:
                        PRScoreView(totalDuration: totalDuration, durations: durations, screenType: .after)
                    }
                    
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
                .navigationBarBackButtonHidden()
                .padding(.bottom, 20)
                .padding(.horizontal,40)
            }
            
            
        }
        .modifier(CustomToolbarModifier())
    }
}

#Preview {
    PRMoodView(type: .after)
}
struct EmojiData{
    var icon: String
    var text: String
}
struct EmojiView: View {
    var text: String
    var emojiImage: String
    @Binding var isSelected: Bool  // Binding for state
    
    var body: some View {
        VStack {
            Image(emojiImage)
                .renderingMode(.template)
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(isSelected ? AppTheme.primaryCTABackgroundColor : Color(hex: "c3d7fd"))
                .scaleEffect(isSelected ? 1.2 : 1.0)  // Scale effect for animation
                .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.2), value: isSelected) // Smooth animation
            
            Text(text)
                .font(.system(size: 20.0, weight: .semibold, design: .rounded))
                .foregroundColor(isSelected ? AppTheme.primaryCTABackgroundColor : AppTheme.primaryTextColor)
                .opacity(isSelected ? 1.0 : 0.7) // Slight opacity change for effect
        }
    }
}

