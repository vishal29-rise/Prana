//
//  Buttons.swift
//  Prana21
//
//  Created by Vishal Thakur on 08/12/24.
//

import SwiftUI

struct RadioButton: View {
    let isSelected: Bool

    var body: some View {
        Circle()
            .stroke(isSelected ? Color.blue : Color.gray, lineWidth: 2)
            .frame(width: 20, height: 20)
            .overlay(
                Circle()
                    .fill(isSelected ? Color.blue : Color.clear)
                    .frame(width: 12, height: 12)
            )
            .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}
