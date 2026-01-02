//
//  KeyboardView.swift
//  Keyboard
//
//  Created by Aryan Jaiswal on 24/12/25.
//

import SwiftUI

enum KeyboardMode {
    case letters
    case numbers
    case symbols
    case emojis
}

struct KeyboardView2: View {
    let onKeyPress: (String) -> Void

    @State private var keyboardMode: KeyboardMode = .letters
    @State private var showPeriodPopup = false
    @State private var showSettings = false
    @StateObject private var themeManager = ThemeManager()
    let utils = Utils()
    
    var body: some View {
        ZStack {
            if showSettings {
                SettingsUIView(showSettings: $showSettings, themeManager: themeManager)
            } else {
                if keyboardMode == .emojis {
                    EmojiUIView(onKeyPress: onKeyPress, showPeriodPopup: $showPeriodPopup, keyboardMode: $keyboardMode, themeManager: themeManager)
                } else {
                    KeyBoardUIView(showSettings: $showSettings, showPeriodPopup: $showPeriodPopup, keyboardMode: $keyboardMode, themeManager:themeManager,onKeyPress: onKeyPress)
                }
            }
            
            // Symbol popup overlay - positioned absolutely above keyboard
            if showPeriodPopup {
                GeometryReader { geometry in
                    SymbolPopUpViewUIView(showPeriodPopup: $showPeriodPopup, onKeyPress: onKeyPress, themeManager: themeManager)
                        .position(x: geometry.size.width * 0.30, y: geometry.size.height - 90)
                        .zIndex(1000)
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
        .padding(.vertical,10)
        .background(themeManager.currentTheme.keyboardBackground)
    }
}
#Preview {
    KeyboardView2(onKeyPress: { key in
        print("Key pressed: \(key)")
    })
}


