//
//  CustomButtonsView.swift
//  CustomKeyboard2
//
//  Created by Aryan Jaiswal on 01/01/26.
//

import SwiftUI

struct CustomButtonsView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// Regular key button
struct KeyButton2: View {
    let key: String
    let color: Color
    let onKeyPress: (String) -> Void
    @Binding var isShifted: Bool
    @Binding var showPeriodPopup: Bool
    @Binding var isCapsLocked: Bool
    @ObservedObject var themeManager: ThemeManager

    var body: some View {
        Button(action: {
            onKeyPress(key)
            showPeriodPopup = false
            // If shift is on and this is a letter and caps lock is not enabled, turn off shift after typing
            if isShifted && !isCapsLocked && key.rangeOfCharacter(from: .letters) != nil {
                isShifted = false
            }
        }) {
            Text(key)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(themeManager.currentTheme.primaryTextColor)
                .frame(height: 44)
                .frame(maxWidth: .infinity)
                .background(color)
                .cornerRadius(4)
                .shadow(color: themeManager.currentTheme.shadowColor, radius: 1, x: 0, y: 1)
        }
    }
}

struct SpaceKeyButton2: View {
    let key: String
    let color: Color
    let onKeyPress: (String) -> Void
    @Binding var isShifted: Bool
    @Binding var showPeriodPopup: Bool
    @Binding var isCapsLocked: Bool
    @ObservedObject var themeManager: ThemeManager

    var body: some View {
        Button(action: {
            onKeyPress(key)
            showPeriodPopup = false
            // If shift is on and this is a letter, turn off shift after typing
            if isShifted && key.rangeOfCharacter(from: .letters) != nil {
                isShifted = false
            }
        }) {

            Text(key)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(themeManager.currentTheme.primaryTextColor)
                .frame(maxWidth: .infinity, maxHeight:  45)
                .background(color)
                .cornerRadius(4)
                .shadow(color: themeManager.currentTheme.shadowColor, radius: 1, x: 0, y: 1)
        }
    }
}

// Special key button (for backspace, shift, return, etc.)
struct SpecialKeyButton2: View {
    let key: String
    let color: Color
    let onKeyPress: (String) -> Void
    @Binding var showPeriodPopup: Bool
    @Binding var isCapsLocked: Bool

    var body: some View {
        Button(action: {
            onKeyPress(key)
            showPeriodPopup = false

        }) {
            Text(key)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.gray)
                .frame(height: 40)
                .frame(minWidth: 40)
                .background(color)
                .cornerRadius(4)
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
        }
    }
}



#Preview {
    CustomButtonsView()
}
