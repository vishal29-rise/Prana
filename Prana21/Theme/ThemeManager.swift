//
//  ThemeManager.swift
//  Prana21
//
//  Created by Vishal Thakur on 01/11/24.
//

import Foundation
import UIKit

import SwiftUI

// Enum for Theme Types
enum ThemeType {
    case light, dark
}

// Theme struct for colors based on type
public struct Theme {
    var type: ThemeType
    
    // Define colors
    var primaryTextColor: Color {
        switch type {
        case .light: return LightTheme.shared.primaryTextColor
        case .dark: return DarkTheme.shared.primaryTextColor
        }
    }
    
    var primaryLightTextColor: Color {
        switch type {
        case .light: return LightTheme.shared.primaryLightTextColor
        case .dark: return DarkTheme.shared.primaryLightTextColor
        }
    }
    
    var secondaryLightTextColor: Color {
        switch type {
        case .light: return LightTheme.shared.secondaryLightTextColor
        case .dark: return DarkTheme.shared.secondaryLightTextColor
        }
    }
    
    var secondaryTextColor: Color {
        switch type {
        case .light: return LightTheme.shared.secondaryTextColor
        case .dark: return DarkTheme.shared.secondaryTextColor
        }
    }
    
    var seperatorColor: Color {
        switch type {
        case .light: return LightTheme.shared.seperatorColor
        case .dark: return DarkTheme.shared.seperatorColor
        }
    }
    
    var quoteViewBackground: Color {
        switch type {
        case .light: return LightTheme.shared.quoteViewBackground
        case .dark: return DarkTheme.shared.quoteViewBackground
        }
    }
    
    var quoteViewTextColor: Color {
        switch type {
        case .light: return LightTheme.shared.quoteViewTextColor
        case .dark: return DarkTheme.shared.quoteViewTextColor
        }
    }
    
    var backgroundColor: Color {
        switch type {
        case .light: return LightTheme.shared.primaryBackground
        case .dark: return DarkTheme.shared.primaryBackground
        }
    }
    
    var accentColor: Color {
        switch type {
        case .light: return .blue
        case .dark: return .yellow
        }
    }
    
    var primaryCTATextColor: Color {
        switch type {
        case .light: return LightTheme.shared.primaryCTAText
        case .dark: return DarkTheme.shared.primaryCTAText
        }
    }
    
    var primaryCTABackgroundColor: Color {
        switch type {
        case .light: return LightTheme.shared.primaryCTABackground
        case .dark: return DarkTheme.shared.primaryCTABackground
        }
    }
    
    var secondaryCTABackgroundColor: Color {
        switch type {
        case .light: return LightTheme.shared.secondaryCTABackground
        case .dark: return DarkTheme.shared.secondaryCTABackground
        }
    }
    
    var textFieldBackground: Color {
        switch type {
        case .light: return LightTheme.shared.textFieldBackground
        case .dark: return DarkTheme.shared.textFieldBackground
        }
    }
    
    var textFieldTextColor: Color {
        switch type {
        case .light: return LightTheme.shared.textFieldTextColor
        case .dark: return DarkTheme.shared.textFieldTextColor
        }
    }
    
    var textPlaceholderColor: Color {
        switch type {
        case .light: return LightTheme.shared.textPlaceholder
        case .dark: return DarkTheme.shared.textPlaceholder
        }
    }
    
    var otpTextColor: Color {
        switch type {
        case .light: return LightTheme.shared.otpTextColor
        case .dark: return DarkTheme.shared.otpTextColor
        }
    }
    
    
}

// ThemeManager singleton with observable object
class ThemeManager: ObservableObject {
    static let shared = ThemeManager()
    
    @Published private(set) var theme: Theme = Theme(type: .light) // Default theme
    
    private init() {}
    
    func setTheme(_ themeType: ThemeType) {
        self.theme = Theme(type: themeType)
    }
    
    //Automatically switch to system theme
    func autoDetectSystemTheme() {
        if UITraitCollection.current.userInterfaceStyle == .dark {
            setTheme(.dark)
        } else {
            setTheme(.light)
        }
    }
}
