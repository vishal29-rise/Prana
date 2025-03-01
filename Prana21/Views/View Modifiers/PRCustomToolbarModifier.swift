//
//  PRCustomToolbarModifier.swift
//  Prana21
//
//  Created by Vishal Thakur on 26/02/25.
//

import SwiftUI

import SwiftUI

struct CustomToolbarModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    btnBack
                }
                ToolbarItem(placement: .topBarTrailing) {
                    btnMute
                }
            }
    }

    // Back Button
    var btnBack: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(Constants.AppImages.backIcon)
                .padding(.top, 10)
        }
    }

    // Mute Button
    var btnMute: some View {
        
        Button(action: {
            BackgroundAudioManager.shared.pause()
        }) {
            Image(systemName: BackgroundAudioManager.shared.isMuted ? "speaker.fill" : "speaker.wave.3")
                .renderingMode(.template)
                .foregroundStyle(AppTheme.primaryCTABackgroundColor)
                .padding(.top, 10)
        }
    }
}
