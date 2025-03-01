//
//  PRVerifyOTPView.swift
//  Prana21
//
//  Created by Vishal Thakur on 04/12/24.
//

import SwiftUI

struct PRVerifyOTPView: View {
    
    //MARK: - State Properties
    @State private var otp = ""
    
    //MARK: - Environment Variables
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    
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
            VStack(){
                Group {
                    
                    Text("Verification Code")
                        .padding(.top,40)
                        .padding(.bottom,20)
                        .font(.custom(Constants.AppFonts.poppinsSemiBold, size: 28.0))
                    
                    Text("Input the verification code we’ve sent your phone number")
                        .padding(.bottom,20)
                    
                        .font(.custom(Constants.AppFonts.poppinsRegular, size: 16.0))
                        .lineSpacing(1.0)
                        .opacity(0.7)
                }
                .frame(maxWidth:.infinity,alignment: .leading)
                

                Spacer(minLength: 20)
                OTPView(otp: $otp)
                    .frame(width: .infinity)
                Spacer(minLength: 50)
                
                HStack{
                    Button(action: {
                        
                    }, label: {
                        Text("Resend")
                            .foregroundColor(.white)
                    })
                    .frame(minWidth: 150,maxWidth: 180,minHeight: 50,maxHeight: 40, alignment: .center)
                    .background(
                        Capsule()
                            .fill(ThemeManager.shared.theme.primaryCTABackgroundColor)
                    )
                    Spacer(minLength: 20)
                    Button(action: {
                        
                    }, label: {
                        Text("Submit")
                            .foregroundColor(.white)
                    })
                    .frame(minWidth: 150,maxWidth: 180,minHeight: 50,maxHeight: 40, alignment: .center)
                    .background(
                        Capsule()
                            .fill(ThemeManager.shared.theme.secondaryCTABackgroundColor)
                    )
                }
                
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal,20.0)
            
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
            ThemeManager.shared.theme.backgroundColor
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
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
}

#Preview {
    PRVerifyOTPView()
}
