//
//  PRSignInView.swift
//  Prana21
//
//  Created by Vishal Thakur on 03/12/24.
//

import SwiftUI

struct PRSignInView: View {
    
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
    
    var body: some View {
        ScrollView {
            VStack(){
                Group {
                    Text("Hi there,")
                        .padding(.top,40)
                        .padding(.bottom,0)
                        .font(.custom(Constants.AppFonts.poppinsLight, size: 22.0))
                    
                    Text("welcome back!")
                        .padding(.bottom,5)
                        .font(.custom(Constants.AppFonts.poppinsSemiBold, size: 28.0))
                    
                    Group {
                        Text("Sign In to a Healthier,")
                            .padding(0)
                        Text("Happier You")
                            .padding(.bottom,20)
                    }
                    .font(.custom(Constants.AppFonts.poppinsRegular, size: 20.0))
                    .foregroundColor(ThemeManager.shared.theme.primaryLightTextColor)
                }
                .frame(maxWidth:.infinity,alignment: .leading)
                

                Spacer(minLength: 20)
                CircularTextField(placeholder: "Email",rightImage: Constants.AppImages.mail,keyboardType: .emailAddress)
                Spacer(minLength: 25)
                CircularTextField(isSecure: true, isSecureField: true,placeholder: "Password",rightImage: Constants.AppImages.eyeOff)
                Spacer(minLength: 15)
                
                NavigationLink(destination: {
                    PRForgotPasswordView()
                }, label: {
                    Text("Forgot Passowrd?")
                        .multilineTextAlignment(.center)
                        .font(.custom(Constants.AppFonts.poppinsRegular, size: 12.0))
                        .foregroundColor(ThemeManager.shared.theme.secondaryLightTextColor)
                })
                
                    
                
                Spacer(minLength: 40)
                
                NavigationLink(destination: {
                    PRFeelingCheckInView()
                }, label: {
                    Text(AppActions.signUp)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 15)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(ThemeManager.shared.theme.primaryCTATextColor)
                })
                .frame(maxWidth: .infinity, alignment: .center)
                .background(
                    Capsule()
                        .fill(ThemeManager.shared.theme.primaryCTABackgroundColor)
                )
                
                
                Spacer(minLength: 40)
                
                Text("Or continue with")
                    .frame(alignment: .center)
                    .multilineTextAlignment(.center)
                    .font(.custom(Constants.AppFonts.poppinsRegular, size: 12.0))
                    .foregroundColor(ThemeManager.shared.theme.secondaryLightTextColor)
                
                Spacer(minLength: 40)
                
                NavigationLink(destination: {
                    PRVerifyOTPView()
                }, label: {
                    Text(AppActions.loginWithApple)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 15)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(ThemeManager.shared.theme.primaryCTATextColor)
                })
                .frame(maxWidth: .infinity, alignment: .center)
                .background(
                    Capsule()
                        .fill(ThemeManager.shared.theme.primaryCTABackgroundColor)
                )
                
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
                btnBack
            })
            
        })
    }
}

#Preview {
    PRSignInView()
}
