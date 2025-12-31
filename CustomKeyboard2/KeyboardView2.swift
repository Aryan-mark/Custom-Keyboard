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
    
    @State private var isShifted = false
    @State private var keyboardMode: KeyboardMode = .letters
    @State private var showPeriodPopup = false
    @State private var isCapsLocked = false
    @State private var showSettings = false
    
    let color = Color.backgroundKeyboard
    let utils = Utils()
    
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
    
    var emojiView: some View {
        VStack(spacing: 5) {
            // Horizontal scrolling emoji rows
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: Array(repeating: GridItem(.flexible()), count: 5), spacing: 5) {
                    ForEach(utils.emojis.flatMap { $0 }, id: \.self) { emoji in
                        Button(action: {
                            onKeyPress(emoji)
                            showPeriodPopup = false
                        }) {
                            Text(emoji)
                                .font(.system(size: 32))
                                .frame(width: 32, height: 32)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal, 5)
            }
        }
        .frame(height: 210)
    }
    
    var body: some View {
        ZStack {
            if showSettings {
                SettingsUIView(showSettings: $showSettings)
            } else {
            if keyboardMode == .emojis {
                // Emoji keyboard
                VStack(spacing: 0) {
                    emojiView
                    
                    // Bottom row with back button and space
                    HStack() {
                        // Back to letters button
                        Button(action: {
                            keyboardMode = .letters
                            showPeriodPopup = false // Dismiss popup when switching modes
                        }) {
                            Text("ABC")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.blue)
                        }.padding(.leading,3)
                        
                        // Backspace
                        Button(action: {
                            onKeyPress("⌫")
                            showPeriodPopup = false
                        }) {
                            Text("⌫")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity,alignment: .trailing)
                        .padding(.trailing,3)
                    }
                    .padding(.horizontal, 5)
                    .padding(.top ,12)
                }.padding(.top,8)
            } else {
                // Regular keyboard
                VStack(alignment: .leading,spacing: 6) {
                    HStack{
                        Button(action: {
                            showSettings = true
                            showPeriodPopup = false
                        }) {
                            Image(systemName: "gear")
                                .foregroundStyle(.black)
                        }
                        .padding(.leading,4)
                        
                        Button(action: {
                            keyboardMode = .emojis
                            showPeriodPopup = false // Dismiss popup when switching modes
                        }) {
                            Text("😀")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.orange)
                        }
                        .frame(maxWidth: .infinity,alignment: .trailing)
                        .padding(.trailing,4)
                    }.padding(0)
                    // Top row
                    
                    VStack(alignment: .leading , spacing: 10){
                        HStack(spacing: 4) {
                            ForEach(topRow, id: \.self) { key in
                                KeyButton2(key: key, color: Color.pink.opacity(0.2), onKeyPress: onKeyPress, isShifted: keyboardMode == .letters ? $isShifted : .constant(false), showPeriodPopup: $showPeriodPopup, isCapsLocked: $isCapsLocked)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, keyboardMode == .letters ? 5 : 5)
                        
                        // Middle row (ASDF...)
                        HStack(spacing: 4) {
                            ForEach(middleRow, id: \.self) { key in
                                KeyButton2(key: key,color: Color.pink.opacity(0.2), onKeyPress: onKeyPress, isShifted: $isShifted,showPeriodPopup: $showPeriodPopup,isCapsLocked: $isCapsLocked)
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
                                    Text(isCapsLocked || isShifted ? "⇪" : "⇧")
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundColor(isCapsLocked ? .blue : isShifted ? .blue : .gray)
                                        .frame(height: 45)
                                        .frame(minWidth: 45)
                                        .background(isCapsLocked ? Color.blue.opacity(0.2) : isShifted ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                                        .cornerRadius(4)
                                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
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
                                    KeyButton2(key: key, color: Color.pink.opacity(0.2), onKeyPress: onKeyPress, isShifted: keyboardMode == .letters ? $isShifted : .constant(false), showPeriodPopup: $showPeriodPopup, isCapsLocked: $isCapsLocked)
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
                                    .foregroundColor(.gray)
                                    .frame(height: 45)
                                    .frame(minWidth: 45)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(4)
                                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
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
                                        .foregroundColor(.black)
                                        .frame(height: 45)
                                        .frame(minWidth: 45)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(4)
                                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
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
                                        .foregroundColor(.black)
                                        .frame(height: 45)
                                        .frame(minWidth: 45)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(4)
                                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
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
                                        .foregroundColor(.black)
                                        .frame(height: 45)
                                        .frame(minWidth: 45)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(4)
                                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                                }
                                .frame(width: 50)
                            }
                            
                            // Separate emoji button
                            
                            ZStack {
                                Button(action: {
                                    if !showPeriodPopup {
                                        onKeyPress(".")
                                        showPeriodPopup = false
                                    }
                                }) {
                                    Text(".")
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundColor(.black)
                                        .frame(height: 44)
                                        .frame(maxWidth: 36)
                                        .background(Color.pink.opacity(0.2))
                                        .cornerRadius(4)
                                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                                }
                                .frame(maxWidth: 36)
                                .simultaneousGesture(
                                    LongPressGesture(minimumDuration: 0.5, maximumDistance: 10)
                                        .onEnded { _ in
                                            showPeriodPopup = true
                                        }
                                )
                                
                                if showPeriodPopup {
                                    SymbolPopUpViewUIView(showPeriodPopup: $showPeriodPopup, onKeyPress: onKeyPress)
                                        .zIndex(0)
                                }
                            }
                            .frame(maxWidth: 36)
                            .padding(.leading,4)
                            
                            // Space bar
                            SpaceKeyButton2(key: "␣", color: Color.orange.opacity(0.2), onKeyPress: onKeyPress, isShifted: .constant(false), showPeriodPopup: $showPeriodPopup, isCapsLocked: $isCapsLocked)
                                .frame(maxWidth: .infinity)
                            
                            Button(action: {
                                onKeyPress("⏎")
                                showPeriodPopup = false
                            }) {
                                Text("⏎")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(.gray)
                                    .frame(height: 45)
                                    .frame(minWidth: 45)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(4)
                                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                            }
                            .frame(width: 50)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal , 3)
                    }
                }
            }
            }
        }
        .padding(.vertical,10)
        .background(color)
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
                .foregroundColor(.black)
                .frame(height: 44)
                .frame(maxWidth: .infinity)
                .background(color)
                .cornerRadius(4)
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
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
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, maxHeight:  45)
                .background(color)
                .cornerRadius(4)
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
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
    KeyboardView2(onKeyPress: { key in
        print("Key pressed: \(key)")
    })
}


