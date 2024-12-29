//
//  PRQuestionaireView.swift
//  Prana21
//
//  Created by Vishal Thakur on 06/12/24.
//

import SwiftUI

struct PRQuestionaireView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    @State private var name: String = ""
    @State private var age: String?
    
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
                    Text("Tell us a little")
                        .padding(.top,40)
                        .padding(.bottom,0)
                        .font(.custom(Constants.AppFonts.poppinsLight, size: 22.0))
                    
                    Text("about you,")
                        .padding(.bottom,50)
                        .font(.custom(Constants.AppFonts.poppinsSemiBold, size: 28.0))
                }
                .frame(maxWidth:.infinity,alignment: .leading)
                
                
                UnderlineTextField(text: $name, placeholder: "What's your name?")
                
                
                MCQView(question: "What is your age?", choices: ["15-25","25-35","35-45","45-55"], selectedChoice: $age)
                    .frame(maxWidth:.infinity,alignment: .leading)
                    .padding(.top,40.0)
                
                MCQView(question: "What gender do you identify as?", choices: ["Woman","Man","Non-binary"], selectedChoice: $age)
                    .frame(maxWidth:.infinity,alignment: .leading)
                    .padding(.top,40.0)
                
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
    PRQuestionaireView()
}
