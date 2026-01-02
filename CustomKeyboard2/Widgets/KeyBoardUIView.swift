//
//  KeyBoardUIView.swift
//  CustomKeyboard2
//
//  Created by Aryan Jaiswal on 01/01/26.
//

import SwiftUI

struct KeyBoardUIView: View {
    
    @Binding var showSettings: Bool
    @Binding var showPeriodPopup: Bool
    @Binding var keyboardMode: KeyboardMode
    @ObservedObject var themeManager: ThemeManager
    let utils = Utils()
    @State private var isShifted = false
    @State private var isCapsLocked = false
    let onKeyPress: (String) -> Void
    
    var topRow: [String] {
        switch keyboardMode {
        case .letters:
            return (isShifted || isCapsLocked) ? utils.topCapsCharacter : utils.topSmallCharacter
        case .numbers:
            return utils.numberRow
        case .symbols:
            return utils.symbolRow1
        case .emojis:
            return []
        }
    }
    
    var middleRow: [String] {
        switch keyboardMode {
        case .letters:
            return (isShifted || isCapsLocked) ? utils.middleCapsCharacter : utils.middleSmallCharacter
        case .numbers:
            return utils.symbolRow2
        case .symbols:
            return utils.symbolRow3
        case .emojis:
            return []
        }
    }
    
    var bottomRow: [String] {
        switch keyboardMode {
        case .letters:
            return (isShifted || isCapsLocked) ? utils.bottomCapsCharacter : utils.bottomSmallCharacter
        case .numbers:
            return utils.symbolRow3
        case .symbols:
            return utils.symbolRow2
        case .emojis:
            return []
        }
    }
    
    var body: some View {
        VStack(alignment: .leading,spacing: 6) {
            HStack{
                Button(action: {
                    showSettings = true
                    showPeriodPopup = false
                }) {
                    Image(systemName: "gear")
                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                }
                .padding(.leading,4)
                
                Button(action: {
                    keyboardMode = .emojis
                    showPeriodPopup = false // Dismiss popup when switching modes
                }) {
                    Text("😀")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(themeManager.currentTheme.accentColor)
                }
                .frame(maxWidth: .infinity,alignment: .trailing)
                .padding(.trailing,4)
            }.padding(0)
            // Top row
            
            VStack(alignment: .leading , spacing: 10){
                HStack(spacing: 4) {
                    ForEach(topRow, id: \.self) { key in
                        KeyButton2(key: key, color: themeManager.currentTheme.primaryKeyBackground, onKeyPress: onKeyPress, isShifted: keyboardMode == .letters ? $isShifted : .constant(false), showPeriodPopup: $showPeriodPopup, isCapsLocked: $isCapsLocked, themeManager: themeManager)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, keyboardMode == .letters ? 5 : 5)
                
                // Middle row (ASDF...)
                HStack(spacing: 4) {
                    ForEach(middleRow, id: \.self) { key in
                        KeyButton2(key: key,color: themeManager.currentTheme.primaryKeyBackground, onKeyPress: onKeyPress, isShifted: $isShifted,showPeriodPopup: $showPeriodPopup,isCapsLocked: $isCapsLocked, themeManager: themeManager)
                    }
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal,20)
                
                // Bottom row
                HStack(spacing: 4) {
                    if keyboardMode == .letters {
                        Button(action: {
                            if isCapsLocked {
                                isCapsLocked = false
                                isShifted = false
                            } else {
                                isShifted.toggle()
                            }
                            showPeriodPopup = false
                        }) {
                            Text(isCapsLocked ? "⇪" : "⇧")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(isCapsLocked ? themeManager.currentTheme.highlightColor : isShifted ? themeManager.currentTheme.highlightColor : themeManager.currentTheme.specialKeyTextColor)
                                .frame(height: 45)
                                .frame(minWidth: 45)
                                .background(isCapsLocked ? themeManager.currentTheme.shiftKeyBackground : isShifted ? themeManager.currentTheme.shiftKeyBackground : themeManager.currentTheme.specialKeyBackground)
                                .cornerRadius(4)
                                .shadow(color: themeManager.currentTheme.shadowColor, radius: 1, x: 0, y: 1)
                        }
                        .frame(width: 50)
                        .simultaneousGesture(
                            TapGesture(count: 2)
                                .onEnded { _ in
                                    // Double click - turn caps lock ON (only when it's OFF)
                                    if !isCapsLocked {
                                        isCapsLocked = true
                                        isShifted = false // Turn off regular shift when caps lock turns on
                                        showPeriodPopup = false
                                    }
                                }
                        )
                    }
                    
                    Spacer().frame(width: 0)
                    // Bottom row keys
                    HStack(spacing: 4) {
                        ForEach(bottomRow, id: \.self) { key in
                            KeyButton2(key: key, color: themeManager.currentTheme.primaryKeyBackground, onKeyPress: onKeyPress, isShifted: keyboardMode == .letters ? $isShifted : .constant(false), showPeriodPopup: $showPeriodPopup, isCapsLocked: $isCapsLocked, themeManager: themeManager)
                        }
                    }
                    Spacer().frame(width: 0)
                    
                    // Backspace key
                    Button(action: {
                        onKeyPress("⌫")
                        showPeriodPopup = false
                    }) {
                        Text("⌫")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(themeManager.currentTheme.specialKeyTextColor)
                            .frame(height: 45)
                            .frame(minWidth: 45)
                            .background(themeManager.currentTheme.specialKeyBackground)
                            .cornerRadius(4)
                            .shadow(color: themeManager.currentTheme.shadowColor, radius: 1, x: 0, y: 1)
                    }
                    .frame(width: 50)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 3)
                .onLongPressGesture {
                    onKeyPress("⌫")
                    showPeriodPopup = false
                }
                
                // Space bar and return row
                HStack(spacing: 4) {
                    // ABC/123 toggle button
                    if keyboardMode != .symbols {
                        Button(action: {
                            keyboardMode = (keyboardMode == .letters) ? .numbers : .letters
                            showPeriodPopup = false
                        }) {
                            Text(keyboardMode == .letters ? "123" : "ABC")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(themeManager.currentTheme.primaryTextColor)
                                .frame(height: 45)
                                .frame(minWidth: 45)
                                .background(themeManager.currentTheme.specialKeyBackground)
                                .cornerRadius(4)
                                .shadow(color: themeManager.currentTheme.shadowColor, radius: 1, x: 0, y: 1)
                        }
                        .frame(width: 50)
                    }
                    
                    // ABC button for symbols mode
                    if keyboardMode == .symbols {
                        Button(action: {
                            keyboardMode = .letters
                            showPeriodPopup = false
                        }) {
                            Text("ABC")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(themeManager.currentTheme.primaryTextColor)
                                .frame(height: 45)
                                .frame(minWidth: 45)
                                .background(themeManager.currentTheme.specialKeyBackground)
                                .cornerRadius(4)
                                .shadow(color: themeManager.currentTheme.shadowColor, radius: 1, x: 0, y: 1)
                        }
                        .frame(width: 50)
                    }
                    
                    // #+= button (shown in numbers and symbols modes)
                    if keyboardMode == .numbers || keyboardMode == .symbols {
                        Button(action: {
                            keyboardMode = (keyboardMode == .numbers) ? .symbols : .numbers
                            showPeriodPopup = false
                        }) {
                            Text(keyboardMode == .numbers ? "#+=" : "123")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(themeManager.currentTheme.primaryTextColor)
                                .frame(height: 45)
                                .frame(minWidth: 45)
                                .background(themeManager.currentTheme.specialKeyBackground)
                                .cornerRadius(4)
                                .shadow(color: themeManager.currentTheme.shadowColor, radius: 1, x: 0, y: 1)
                        }
                        .frame(width: 50)
                    }
                    
                    // Separate emoji button
                    
                    Button(action: {
                        if !showPeriodPopup {
                            onKeyPress(".")
                            showPeriodPopup = false
                        }
                    }) {
                        Text(".")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(themeManager.currentTheme.primaryTextColor)
                            .frame(height: 44)
                            .frame(maxWidth: 36)
                            .background(themeManager.currentTheme.primaryKeyBackground)
                            .cornerRadius(4)
                            .shadow(color: themeManager.currentTheme.shadowColor, radius: 1, x: 0, y: 1)
                    }
                    .frame(maxWidth: 36)
                    .simultaneousGesture(
                        LongPressGesture(minimumDuration: 0.5, maximumDistance: 10)
                            .onEnded { _ in
                                showPeriodPopup = true
                            }
                    )
                    .padding(.leading,4)
                    
                    // Space bar
                    SpaceKeyButton2(key: "␣", color: themeManager.currentTheme.spaceKeyBackground, onKeyPress: onKeyPress, isShifted: .constant(false), showPeriodPopup: $showPeriodPopup, isCapsLocked: $isCapsLocked, themeManager: themeManager)
                        .frame(maxWidth: .infinity)
                    
                    Button(action: {
                        onKeyPress("⏎")
                        showPeriodPopup = false
                    }) {
                        Text("⏎")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(themeManager.currentTheme.specialKeyTextColor)
                            .frame(height: 45)
                            .frame(minWidth: 45)
                            .background(themeManager.currentTheme.specialKeyBackground)
                            .cornerRadius(4)
                            .shadow(color: themeManager.currentTheme.shadowColor, radius: 1, x: 0, y: 1)
                    }
                    .frame(width: 50)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal , 3)
            }
        }
    }
}

#Preview {
    KeyBoardUIView(showSettings: .constant(false), showPeriodPopup: .constant(false), keyboardMode: .constant(.letters), themeManager: ThemeManager(),onKeyPress: {key in print(key)})
}

