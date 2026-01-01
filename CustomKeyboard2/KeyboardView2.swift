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
    
    var body: some View {
        ZStack {
            if showSettings {
                SettingsUIView(showSettings: $showSettings)
            } else {
            if keyboardMode == .emojis {
                // Emoji keyboard
              EmojiUIView(onKeyPress: onKeyPress, showPeriodPopup: $showPeriodPopup, keyboardMode: $keyboardMode)
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
                                    Text(isCapsLocked ? "⇪" : "⇧")
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

            // Symbol popup overlay - positioned absolutely above keyboard
            if showPeriodPopup {
                GeometryReader { geometry in
                    SymbolPopUpViewUIView(showPeriodPopup: $showPeriodPopup, onKeyPress: onKeyPress)
                        .position(x: geometry.size.width * 0.30, y: geometry.size.height - 90)
                        .zIndex(1000)
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
        .padding(.vertical,10)
        .background(color)
    }
}
#Preview {
    KeyboardView2(onKeyPress: { key in
        print("Key pressed: \(key)")
    })
}


