//
//  DarkTheme.swift
//  Prana21
//
//  Created by Vishal Thakur on 01/11/24.
//

import Foundation
import SwiftUI

struct DarkTheme {
    static var shared = DarkTheme()
    
    var primaryTextColor : Color = Color(hex: "#FFFFFF")
    var primaryLightTextColor: Color = Color(hex: "#D0D5DD")
    var primaryBackground : Color = Color(hex: "#141D35")
    var primaryCTAText: Color = .white
    var primaryCTABackground: Color = Color(hex: "#4FC106")
    
    var secondaryTextColor : Color = .black
    var secondaryLightTextColor: Color = Color(hex: "#D0D5DD")
    var secondaryBackground : Color = .white
    var secondaryCTAText: Color = .white
    var secondaryCTABackground: Color = Color(hex: "#026666")
    
    var seperatorColor: Color = Color(hex: "#8B8585")
    var quoteViewBackground: Color = Color(hex: "#ECAC16")
    var quoteViewTextColor: Color = Color(hex: "#000000")
    
    var textFieldBackground: Color = .white
    var textFieldTextColor: Color = .black
    var otpTextColor: Color = Color(hex: "#026666")
    var textPlaceholder: Color = Color(hex: "#9A9797")
}
