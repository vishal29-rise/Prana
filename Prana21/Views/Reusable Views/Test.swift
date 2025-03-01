//
//  Test.swift
//  Prana21
//
//  Created by Vishal Thakur on 26/02/25.
//

import SwiftUI

struct Test: View {
    var body: some View {
        ZStack{
            Color.black
            Image(Constants.AppImages.aura5)
                .resizable()
                .frame(width: 290,height: 290)
                .aspectRatio(contentMode: .fill)
                
                
            
            Image(Constants.AppImages.aura4)
                .resizable()
                .frame(width: 290,height: 290)
                .aspectRatio(contentMode: .fill)
                
                
            
            
           
            Image(Constants.AppImages.aura3)
                .resizable()
                .frame(width: 290,height: 290)
                .aspectRatio(contentMode: .fill)
                
                
            
            
            Image(Constants.AppImages.aura2)
                .resizable()
                .frame(width: 230,height: 230)
                .aspectRatio(contentMode: .fill)
                
                //.frame(width: geometry.size.width * 0.7,height: geometry.size.height * 0.7)
    
            Image(Constants.AppImages.aura1)
                .resizable()
                .frame(width: 170,height: 170)
                .aspectRatio(contentMode: .fill)
                
                
            
            
             
                
        }
    }
}

//#Preview {
//    Test()
//}
