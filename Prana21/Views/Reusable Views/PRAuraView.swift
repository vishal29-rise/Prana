//
//  PRAuraView.swift
//  Prana21
//
//  Created by Vishal Thakur on 15/02/25.
//

import SwiftUI

struct PRAuraView: View {
    @State private var showAura1 = false
    @State private var showAura2 = false
    @State private var showAura3 = false
    @State private var showAura4 = false
    @State private var showAura5 = false
    @State var hideLogo: Bool
    @Binding var isVisible: Bool
    
    
    var body: some View {
        GeometryReader{ geometry in
            
            ZStack(alignment: .center) {
                Image(Constants.AppImages.aura5)
                    .resizable()
                    .frame(width: 290,height: 290)
                    .aspectRatio(contentMode: .fill)
                    .opacity(isVisible ? 1 : 0)
                    .animation(.easeIn(duration: 1).delay(isVisible ? 5 : 1), value: isVisible)
                
                Image(Constants.AppImages.aura5)
                    .resizable()
                    .frame(width: 290,height: 290)
                    .aspectRatio(contentMode: .fill)
                    .opacity(isVisible ? 1 : 0)
                    .animation(.easeIn(duration: 1).delay(isVisible ? 5 : 1), value: isVisible)
                    
                
                Image(Constants.AppImages.aura4)
                    .resizable()
                    .frame(width: 290,height: 290)
                    .aspectRatio(contentMode: .fill)
                    .opacity(isVisible ? 1 : 0)
                    .animation(.easeIn(duration: 1).delay(isVisible ? 4 : 2), value: isVisible)
                    
                
                
               
                Image(Constants.AppImages.aura3)
                    .resizable()
                    .frame(width: 290,height: 290)
                    .aspectRatio(contentMode: .fill)
                    .opacity(isVisible ? 1 : 0)
                    .animation(.easeIn(duration: 1).delay(isVisible ? 3 : 3), value: isVisible)
                    
                
                
                Image(Constants.AppImages.aura2)
                    .resizable()
                    .frame(width: 230,height: 230)
                    .aspectRatio(contentMode: .fill)
                    .opacity(isVisible ? 1 : 0)
                    .animation(.easeIn(duration: 1).delay(isVisible ? 2 : 4), value: isVisible)
                    
        
                Image(Constants.AppImages.aura1)
                    .resizable()
                    .frame(width: 150,height: 150)
                    .aspectRatio(contentMode: .fill)
                    .opacity(isVisible ? 1 : 0)
                    .animation(.easeIn(duration: 1).delay(isVisible ? 1 : 4), value: isVisible)
                    
                if !hideLogo {
                    Image(Constants.AppImages.light_logo)
                        .resizable()
                        .frame(width: 75,height: 75)
                        .aspectRatio(contentMode: .fit)
                    
                }
                    
            }
            .frame(width: geometry.size.width, height: geometry.size.height) // Ensure ZStack fills the GeometryReader
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
//            .onAppear {
//                animateForward()
//                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {animateBackward() }
//            }
        }
    }
    
    func animateForward(){
        isVisible = true
        
    }
    
    func animateBackward(){
       
       
       
        isVisible = false
        
    }
}

//#Preview {
//    PRAuraView(isVisible: true)
//}
