//
//  MCQView.swift
//  Prana21
//
//  Created by Vishal Thakur on 09/12/24.
//

import SwiftUI

struct MCQView: View {
    let question: String
    let choices: [String]
    @Binding var selectedChoice: String?

    var body: some View {
        VStack(alignment: .leading) {
            Text(question)
                .font(.custom(Constants.AppFonts.poppinsMedium, size: 20.0))
                .foregroundColor(ThemeManager.shared.theme.primaryLightTextColor)
                .padding(.bottom, 8)
            
            ForEach(choices, id: \.self) { choice in
                HStack {
                    RadioButton(isSelected: selectedChoice == choice)
                        .onTapGesture {
                            selectedChoice = choice
                        }
                    Text(choice)
                        .font(.body)
                        .onTapGesture {
                            selectedChoice = choice
                        }
                }
                .padding(.vertical, 8)
            }
        }
       
        
    }
}
