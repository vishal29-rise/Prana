///
///  PRSignupView.swift
///  Prana21
//
//  Created by Vishal Thakur on 01/12/24.


import SwiftUI

struct PRSignupView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ScrollView {
            VStack(){
                
                Group {
                    Text("New User?")
                        .padding(.top,40)
                        .padding(.bottom,0)
                        .font(.custom(Constants.AppFonts.poppinsLight, size: 22.0))
                    
                    Text("Create an account")
                        .padding(.bottom,5)
                        .font(.custom(Constants.AppFonts.poppinsSemiBold, size: 28.0))
                    
                    Group {
                        Text("Join Prana,")
                            .padding(.bottom,0)
                        Text("Your First Step to Inner Peace")
                            .padding(.bottom,20)
                    }
                    .font(.custom(Constants.AppFonts.poppinsRegular, size: 20.0))
                    .foregroundColor(ThemeManager.shared.theme.primaryLightTextColor)
                }
                .frame(maxWidth:.infinity,alignment: .leading)
                
                
                CircularTextField(placeholder: "Enter Name",keyboardType: .namePhonePad)
                Spacer(minLength: 25)
                CircularTextField(placeholder: "Enter Email",rightImage: Constants.AppImages.mail,keyboardType: .emailAddress)
                Spacer(minLength: 25)
                CircularTextField(placeholder: "Enter Phone Number",rightImage: Constants.AppImages.phone,keyboardType: .phonePad)
                Spacer(minLength: 25)
                CircularTextField(isSecure: true,isSecureField: true, placeholder: "Set Password",rightImage: Constants.AppImages.eyeOff)
                Spacer(minLength: 25)
                CircularTextField(isSecure: true,isSecureField: true, placeholder: "Confirm Password",rightImage: Constants.AppImages.eyeOff)
                Spacer(minLength: 25)
                Text("By continuing, you agree to the Conditions, and Privacy Policy")
                    .frame(alignment: .center)
                    .multilineTextAlignment(.center)
                    .font(.custom(Constants.AppFonts.poppinsRegular, size: 12.0))
                    .foregroundColor(ThemeManager.shared.theme.secondaryLightTextColor)
                
                Spacer(minLength: 20)
                
                NavigationLink(destination: {
                    PRQuestionaireView()
                }, label: {
                    Text(AppActions.signUp)
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
                
                Text("Have an account?")
                    .font(.custom(Constants.AppFonts.poppinsMedium, size: 12.0))
                
                NavigationLink(destination: {
                    PRSignInView()
                }, label: {
                    Text(AppActions.signIn)
                        .padding(.horizontal, 40)
                        .font(.custom(Constants.AppFonts.poppinsMedium, size: 18.0))
                        .fontWeight(.semibold)
                        .foregroundColor(ThemeManager.shared.theme.primaryCTABackgroundColor)
                })
                
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal,20.0)
            
        }
        .background {
            ThemeManager.shared.theme.backgroundColor
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        }
        .navigationBarBackButtonHidden()
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
    PRSignupView()
}
