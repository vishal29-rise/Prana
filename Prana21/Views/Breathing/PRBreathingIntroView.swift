//
//  PRBreathingIntroView.swift
//  Prana21
//
//  Created by Vishal Thakur on 14/12/24.
//

import SwiftUI

struct PRBreathingIntroView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    @State private var name: String = ""
    @State private var age: String?
    
    var btnBack : some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(Constants.AppImages.backIcon)
                .renderingMode(.template)
                .foregroundColor(.white)
                .padding([.top],10)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(){
                
                
                Group {
                    Text("Hi Vishal,")
                        .padding(.top,20)
                        .padding(.bottom,0)
                        .font(.custom(Constants.AppFonts.poppinsLight, size: 22.0))
                    
                    Text("I am Prana")
                        .padding(.bottom,50)
                        .font(.custom(Constants.AppFonts.poppinsSemiBold, size: 28.0))
                }
                .frame(maxWidth:.infinity,alignment: .leading)
                .foregroundColor(.white)
                
                Spacer(minLength: 140)
                Image(Constants.AppImages.monk)
                    
                Group {
                    VStack(alignment: .leading){
                        Text("Box Breathing")
                            .font(.custom(Constants.AppFonts.poppinsSemiBold, size: 20.0))
                        Spacer(minLength: 0)
                        HStack {
                            HStack {
                                Image(Constants.AppImages.star_filled)
                                Text("4.5")
                            }
                            
                            Text("Scott & shanice")
                        }
                        .font(.custom(Constants.AppFonts.poppinsRegular, size: 12.0))
                        .padding(.bottom,20)
                        
                        
                        HStack {
                            Image(Constants.AppImages.clockIcon)
                            
                            Text("30 secs, Intermediate")
                        }
                        .font(.custom(Constants.AppFonts.poppinsMedium, size: 14.0))
                        .padding(.bottom,15)
                        
                        HStack {
                            Image(Constants.AppImages.blackholeicon)
                            
                            Text("Meditation, Breathing, sleep")
                        }
                        .font(.custom(Constants.AppFonts.poppinsMedium, size: 14.0))
                    }
                }
                .foregroundColor(.white)
                .frame(maxWidth:.infinity,alignment: .leading)
                
                VStack {
                    Text("Your guide to relax better")
                        .foregroundColor(.white)
                        .frame(maxWidth:.infinity,alignment: .center)
                        .font(.custom(Constants.AppFonts.poppinsMedium, size: 24.0))
                        
                    NavigationLink(destination: {
                        PRBenefitsScreen()
                    }, label: {
                        Text(AppActions.letsGo)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 10)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(ThemeManager.shared.theme.primaryCTATextColor)
                    })
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(
                        Capsule()
                            .fill(ThemeManager.shared.theme.primaryCTABackgroundColor)
                    )
                    
                    Spacer(minLength: 20)
                }
                .padding(.top,20)
                .frame(maxWidth: .infinity)
                
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal,25.0)
            
        }
        .onChange(of: colorScheme) { (oldColorScheme,newColorScheme) in
                    // Update the theme automatically when system theme changes
                    if newColorScheme == .dark {
                        ThemeManager.shared.setTheme(.dark)
                    } else {
                        ThemeManager.shared.setTheme(.light)
                    }
                }

        .background {
            Image(Constants.AppImages.breathingBackground)
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        }
        .navigationBarBackButtonHidden()
        .toolbar(content: {
            ToolbarItem( placement: .topBarLeading,content: {
                btnBack
            })
            
            ToolbarItem( placement: .topBarTrailing,content: {
                HStack {
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Image(Constants.AppImages.bookmark)
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        Image(Constants.AppImages.share)
                    })
                }
            })
            
        })
    }
}

#Preview {
    PRBreathingIntroView()
}
