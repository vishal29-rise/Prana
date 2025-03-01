//
//  PRIntoView.swift
//  Prana21
//
//  Created by Vishal Thakur on 18/01/25.
//

import SwiftUI

struct PRIntoView: View {
    
    @State private var buttonColor = ThemeManager.shared.theme.primaryCTABackgroundColor
    @State private var isVisible = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                GeometryReader { geometry in
                    Image(Constants.AppImages.introView)
                        .resizable()
                        .ignoresSafeArea(edges: .all)
                    
                    VStack {
                        ZStack(alignment: .center) {
                            PRAuraView(hideLogo: false, isVisible: $isVisible) .onAppear{
                                DispatchQueue.main.async {
                                    self.isVisible = true
                                }
                            }
//                            Image(Constants.AppImages.light_logo)
//                                .resizable()
//                                .frame(width: 75,height: 75)
//                                .aspectRatio(contentMode: .fit)
                                
                            
                        }
                        
                        .padding(.bottom,20)
                        .frame(width: geometry.size.width * 0.8,height: geometry.size.height * 0.35)
                        .padding(.top, 20)
                        
                        VStack {
                            Group {
                                Group {
                                    Text(AppTexts.crush_Stress)
                                        .font(.system(size: 24.0,weight: .semibold,design: .rounded))
                                    
                                    //.fontWeight(600)
                                    Text(AppTexts.sleep_Better)
                                        .font(.system(size: 32.0,weight: .semibold,design: .rounded))
                                    
                                }
                                .foregroundColor(AppTheme.primaryTextColor)
                                Text(AppTexts.live_longer)
                                    .font(.system(size: 40.0,weight: .semibold,design: .rounded))
                                    .foregroundColor(AppTheme.primaryCTABackgroundColor)
                                
                            }
                            
                        }
                        
                        Spacer()
                        NavigationLink(destination: {
                            PROnboardingView()
                        }, label: {
                            Text(AppActions.how)
                                .padding(.horizontal, 40)
                                .padding(.vertical, 15)
                                .font(.custom(Constants.AppFonts.inter18SemiBold, size: 20.0))
                                .foregroundColor(ThemeManager.shared.theme.primaryCTATextColor)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .animation(.easeOut(duration: 0.2),value: buttonColor)
                        })
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(
                            Capsule()
                                .fill(buttonColor)
                            
                        )
                        .navigationBarBackButtonHidden()
                        .padding(.bottom, 20)
                        .padding(.horizontal,40)
                        
                    }
                }
            }
        }
    }
}

#Preview {
    PRIntoView()
}

struct PulsatingBackground: View {
    @State private var pulseAnimation = false

    var body: some View {
        ZStack {
            // Background with pulsing animation
            ForEach(0..<9) { _ in
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .scaleEffect(pulseAnimation ? 1.1 : 1)
                    .opacity(pulseAnimation ? 0.5 : 1)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
                    .offset(x: CGFloat.random(in: -20...20), y: CGFloat.random(in: -5...5))
            }
            .onAppear {
                self.pulseAnimation = true
            }
        }
    }
}
