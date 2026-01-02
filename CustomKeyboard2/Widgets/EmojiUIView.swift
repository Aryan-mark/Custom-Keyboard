//
//  EmojiUIView.swift
//  CustomKeyboard2
//
//  Created by Aryan Jaiswal on 01/01/26.
//

import SwiftUI

struct EmojiUIView: View {
    let onKeyPress: (String) -> Void
    @Binding var showPeriodPopup: Bool
    @Binding var keyboardMode: KeyboardMode
    @ObservedObject var themeManager: ThemeManager

    var body: some View {
        VStack(spacing: 0) {
            Emojis(onKeyPress: onKeyPress, showPeriodPopup: $showPeriodPopup, themeManager: themeManager)

            // Bottom row with back button and space
            HStack() {
                // Back to letters button
                Button(action: {
                    keyboardMode = .letters
                    showPeriodPopup = false // Dismiss popup when switching modes
                }) {
                    Text("ABC")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(themeManager.currentTheme.accentColor)
                }.padding(.leading,3)

                // Backspace
                Button(action: {
                    onKeyPress("⌫")
                    showPeriodPopup = false
                }) {
                    Text("⌫")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(themeManager.currentTheme.specialKeyTextColor)
                }
                .frame(maxWidth: .infinity,alignment: .trailing)
                .padding(.trailing,3)
            }
            .padding(.horizontal, 5)
            .padding(.top ,12)
        }.padding(.top,8)    }
}

#Preview {
    EmojiUIView(onKeyPress: {key in print(key)}, showPeriodPopup: .constant(false), keyboardMode: .constant(.emojis), themeManager: ThemeManager())
}
