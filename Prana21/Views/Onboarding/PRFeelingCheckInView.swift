//
//  PRFeelingCheckInView.swift
//  Prana21
//
//  Created by Vishal Thakur on 05/11/24.
//

import SwiftUI


struct EmojiItem: Identifiable {
    let id = UUID()
    let emoji: String
    let title: String
}


struct PRFeelingCheckInView: View {
    
    //MARK: - Properties
    let emojiList = [
        EmojiItem(emoji: "happy_emoji", title: "Happy"),
        EmojiItem(emoji: "neutral_emoji", title: "Neutral"),
        EmojiItem(emoji: "confused_emoji", title: "Confused"),
        EmojiItem(emoji: "angry_emoji", title: "Angry"),
        EmojiItem(emoji: "anxious_emoji", title: "Anxious"),
        EmojiItem(emoji: "upset_emoji", title: "Upset")
    ]
    let emoji = EmojiItem(emoji: "stressed_emoji", title: "Stressed")
    let columns = [
        GridItem(.flexible(minimum: 0.0, maximum: .infinity)),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    //MARK: - Environment Variables
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
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
        ScrollView {
            VStack {
                VStack {
                    Group {
                        Text("Hello,")
                            .padding(.top,30)
                            .padding(.bottom,0)
                            .font(.custom(Constants.AppFonts.poppinsLight, size: 22.0))
                        
                        Text("Vishal")
                            .padding(.bottom,5)
                            .font(.custom(Constants.AppFonts.poppinsSemiBold, size: 28.0))
                        
                        
                        Text("How are you feeling ?")
                            .padding(.bottom,15)
                            .padding(.top,20)
                            .font(.custom(Constants.AppFonts.poppinsMedium, size: 20.0))
                            .foregroundColor(ThemeManager.shared.theme.primaryLightTextColor)
                    }
                    .frame(maxWidth:.infinity,alignment: .leading)
                    
                    
                    Spacer(minLength: 20)
                    
                    LazyVGrid(columns: columns,alignment: .center, spacing: 35)  {
                        ForEach(emojiList) { emoji in
                            VStack(alignment: .center) {
                                Image(emoji.emoji)
                                    .frame(width: 60,height: 60)
                                    .padding(.bottom, 10)
                                
                                Spacer()
                                
                                Text(emoji.title.capitalized)
                                    .font(.custom(Constants.AppFonts.comfortaSemibold, size: 15.0))
                                    .padding(.bottom, 10)
                                    .foregroundStyle(ThemeManager.shared.theme.primaryTextColor)
                            }
                            
                            
                        }
                        
                    }
                    Spacer(minLength: 25)
                    VStack(alignment: .center) {
                        Image(emoji.emoji)
                            .frame(width: 60,height: 60)
                            .padding(.bottom, 10)
                        
                        Spacer()
                        
                        Text(emoji.title.capitalized)
                            .font(.custom(Constants.AppFonts.comfortaSemibold, size: 15.0))
                            .padding(.bottom, 15)
                            .foregroundStyle(ThemeManager.shared.theme.primaryTextColor)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal,20.0)
                QuoteView()
                Spacer(minLength: 10)
                NavigationLink(destination: {
                    PRBreathingIntroView()
                }, label: {
                    Text(AppActions.next)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 10)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(ThemeManager.shared.theme.primaryCTATextColor)
                })
                .background(
                    Capsule()
                        .fill(ThemeManager.shared.theme.primaryCTABackgroundColor)
                )
                Spacer(minLength: 10)
            }
        }
        .background(content: {
            ThemeManager.shared.theme.backgroundColor
                .ignoresSafeArea(edges: .all)
                .scaledToFill()
        })
        .scrollIndicators(.hidden)
        .navigationBarBackButtonHidden()
        .toolbar(content: {
                ToolbarItem( placement: .topBarLeading,content: {
                    HStack(content: {
                        btnBack
                        Spacer()
                        btnMute
                    })
                })
                
                
            })
        .onChange(of: colorScheme) { (oldColorScheme,newColorScheme) in
            // Update the theme automatically when system theme changes
            if newColorScheme == .dark {
                ThemeManager.shared.setTheme(.dark)
            } else {
                ThemeManager.shared.setTheme(.light)
            }
        }
        
    }
}

#Preview {
    PRFeelingCheckInView()
}

struct QuoteView: View {
    var body: some View {
        ZStack {
            
            VStack(alignment: .leading){
                Text("NATHANIEL BRANDEN")
                    .font(.custom(Constants.AppFonts.poppinsRegular, size: 12.0))
                Text("The first step toward change is awareness. The second step is acceptance.")
                    .font(.custom(Constants.AppFonts.poppinsMedium, size: 14.0))
                
            }
            .foregroundColor(ThemeManager.shared.theme.quoteViewTextColor)
            .frame(maxWidth: .infinity)
            .padding(20)
            .background {
                ThemeManager.shared.theme.quoteViewBackground
            }
            
            HStack {
                Spacer()
                VStack{
                    Spacer()
                    Image(Constants.AppImages.like)
                        .padding([.bottom,.trailing],10)
                    
                }
            }
        }
    }
}
