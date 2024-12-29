//
//  LightTheme.swift
//  Prana21
//
//  Created by Vishal Thakur on 01/11/24.
//

import Foundation
import UIKit
import SwiftUI

struct LightTheme {
    static let shared = LightTheme()
    
    var primaryTextColor : Color = .black
    var primaryLightTextColor: Color = Color(hex: "#727272")
    var primaryBackground : Color = Color(hex: "#EAEAEA")
    var primaryCTAText: Color = .white
    var primaryCTABackground: Color = Color(hex: "#4FC106")
    
    var secondaryTextColor : Color = .black
    var secondaryLightTextColor: Color = Color(hex: "#4F5366")
    var secondaryBackground : Color = .white
    var secondaryCTAText: Color = .white
    var secondaryCTABackground: Color = Color(hex: "#026666")
   
    
    var seperatorColor: Color = .black
    
    var quoteViewBackground: Color = Color(hex: "#1B2E5E")
    var quoteViewTextColor: Color = Color(hex: "#F4FAEF")
    
    var textFieldBackground: Color = .white
    var textFieldTextColor: Color = .black
    var otpTextColor: Color = Color(hex: "#026666")
    var textPlaceholder: Color = Color(hex: "#9A9797")
}
