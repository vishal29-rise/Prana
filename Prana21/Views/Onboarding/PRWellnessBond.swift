//
//  PRWellnessBond.swift
//  Prana21
//
//  Created by Vishal Thakur on 17/12/24.
//

import SwiftUI

struct PRWellnessBond: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    
    
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
       
            VStack(){
                Group {
                    Text("Sign the")
                        .padding(.top,10)
                        .padding(.bottom,0)
                        .font(.custom(Constants.AppFonts.poppinsLight, size: 20.0))
                        .foregroundColor(Color(hex: "#727272"))
                    
                    Text("Wellness Bond")
                        .padding(.bottom,50)
                        .font(.custom(Constants.AppFonts.poppinsSemiBold, size: 28.0))
                        .lineSpacing(0)
                        .foregroundColor(.black)
                }
                .frame(maxWidth:.infinity,alignment: .leading)
                
                Spacer()
                // Get Started button with capsule style
                NavigationLink(destination: {
                    PRSignupView()
                }, label: {
                    Text(AppActions.ready)
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
                .padding(.bottom, 5)
                
            }
            .padding(.horizontal,20.0)
            .frame(maxWidth: .infinity)
            
            
       
        .onChange(of: colorScheme) { (oldColorScheme,newColorScheme) in
                    // Update the theme automatically when system theme changes
                    if newColorScheme == .dark {
                        ThemeManager.shared.setTheme(.dark)
                    } else {
                        ThemeManager.shared.setTheme(.light)
                    }
                }

        .background {
            Image(Constants.AppImages.wellnessBond)
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
    PRWellnessBond()
}
