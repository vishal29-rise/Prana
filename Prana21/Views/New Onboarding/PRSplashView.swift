//
//  PRSplashView.swift
//  Prana21
//
//  Created by Vishal Thakur on 21/02/25.
//

import SwiftUI

struct PRSplashView: View {
    @State private var isVisible = false
    @State private var willMoveToNextScreen = false

    var body: some View {
        
        ZStack(alignment: .center) {
            Image(Constants.AppImages.splash)
                .resizable()
                .ignoresSafeArea(edges: .all)
            VStack(alignment: .center){
                Spacer()
                ZStack(alignment: .center){
                    PRAuraView(hideLogo: false,isVisible: $isVisible) .onAppear{
                        DispatchQueue.main.async {
                            self.isVisible = true
                        }
                    }
                    .frame(width: 350,height: 350)

                }
                Spacer()
                VStack{
                    Text("powered by")
                        .foregroundStyle(.white)
                        .font(.system(size: 14.0))
                    Text("Ritva.ai")
                        .foregroundStyle(.white)
                        .font(.system(size: 22.0))
                        .fontWeight(.bold)
                }
                
            }
            
        }.task {
            DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                willMoveToNextScreen = true
            })
        }
        .navigate(to: PRIntoView(), when: $willMoveToNextScreen)
    }
}

#Preview {
    PRSplashView()
}
