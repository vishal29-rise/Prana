//
//  PRAgeSelectionView.swift
//  Prana21
//
//  Created by Vishal Thakur on 02/02/25.
//

import SwiftUI

struct PRAgeSelectionView: View {
    let ageRanges = ["15-25", "25-35", "35-45", "45-55", "55+"]
    @Binding var selectedRange: String // Default selection
    
    var body: some View {
        VStack(spacing: 20) {
            
            
            ZStack {
                // Connecting line
                Rectangle()
                    .fill(Color.white.opacity(0.6))
                    .frame(height: 4)
                    .frame(width: UIScreen.main.bounds.width * 0.7)
                    .offset(y: -10) // Align with circles
                
                HStack {
                    ForEach(ageRanges, id: \.self) { range in
                        VStack {
                            Circle()
                                .fill(selectedRange == range ? Color(ThemeManager.shared.theme.primaryCTABackgroundColor) : Color(hex: "#BDE2FF"))
                                .frame(width: 30, height: 30)
                                
                                .onTapGesture {
                                    withAnimation {
                                        selectedRange = range
                                    }
                                }
                            
                            Text(range)
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                        if range != ageRanges.last ?? "" {
                            Spacer()
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.8)
            }
            
        }
        .background(Color.clear)
        
    }
}
