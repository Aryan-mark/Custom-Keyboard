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
}

struct KeyboardView2: View {
    let onKeyPress: (String) -> Void

    @State private var isShifted = false
    @State private var keyboardMode: KeyboardMode = .letters

    // Keyboard layouts
    
    let topCapsCharacter = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
    let topSmallCharacter = ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"]
    let middleCapsCharacter = ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
    let middleSmallCharacter = ["a", "s", "d", "f", "g", "h", "j", "k", "l"]
    let bottomCapsCharacter = ["Z", "X", "C", "V", "B", "N", "M"]
    let bottomSmallCharacter = ["z", "x", "c", "v", "b", "n", "m"]
    
    let numberRow = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    let symbolRow1 = ["!", "@", "#", "$", "%", "^", "&", "*", "(", ")"]
    let symbolRow2 = ["-", "_", "=", "+", "[", "]", "{", "}", "\\", "|"]
    let symbolRow3 = [":", ";", "\"", "'", "<", ">", ",", ".", "?", "/"]
    
    var topRow: [String] {
        switch keyboardMode {
        case .letters:
            return isShifted ? topCapsCharacter : topSmallCharacter
        case .numbers:
            return numberRow
        case .symbols:
            return symbolRow1
        }
    }

    var middleRow: [String] {
        switch keyboardMode {
        case .letters:
            return isShifted ? middleCapsCharacter : middleSmallCharacter
        case .numbers:
            return symbolRow2
        case .symbols:
            return symbolRow3
        }
    }

    var bottomRow: [String] {
        switch keyboardMode {
        case .letters:
            return isShifted ? bottomCapsCharacter : bottomSmallCharacter
        case .numbers:
            return symbolRow3
        case .symbols:
            return symbolRow2
        }
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading , spacing: 12) {
                // Top row
                HStack(spacing: 5) {
                    ForEach(topRow, id: \.self) { key in
                        KeyButton2(key: key, color: Color.pink.opacity(0.2), onKeyPress: onKeyPress, isShifted: keyboardMode == .letters ? $isShifted : .constant(false))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, keyboardMode == .letters ? 8 : 8)
                
                // Middle row (ASDF...)
                HStack(spacing: 4) {
                    ForEach(middleRow, id: \.self) { key in
                        KeyButton2(key: key,color: Color.pink.opacity(0.2), onKeyPress: onKeyPress, isShifted: $isShifted)
                    }
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal,25)
                
                // Bottom row
                HStack(spacing: 5) {
                    if keyboardMode == .letters {
                        Button(action: {
                            isShifted.toggle()
                        }) {
                            Text("⇧")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(isShifted ? .blue : .gray)
                                .frame(height: 45)
                                .frame(minWidth: 45)
                                .background(isShifted ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                                .cornerRadius(4)
                                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                        }
                        .frame(width: 50)
                    }

                    Spacer().frame(width: 0)
                    // Bottom row keys
                    HStack(spacing: 5) {
                        ForEach(bottomRow, id: \.self) { key in
                            KeyButton2(key: key, color: Color.pink.opacity(0.2), onKeyPress: onKeyPress, isShifted: keyboardMode == .letters ? $isShifted : .constant(false))
                        }
                    }
                    Spacer().frame(width: 0)

                    // Backspace key
                    Button(action: {
                        onKeyPress("⌫")
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
                .padding(.horizontal, 5)
                
                // Space bar and return row
                HStack(spacing: 5) {

                    // Mode switch button
                    Button(action: {
                        switch keyboardMode {
                        case .letters:
                            keyboardMode = .numbers
                        case .numbers:
                            keyboardMode = .symbols
                        case .symbols:
                            keyboardMode = .letters
                        }
                    }) {
                        Text(keyboardMode == .letters ? "123" : keyboardMode == .numbers ? "#+=" : "ABC")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.blue)
                            .frame(height: 45)
                            .frame(minWidth: 45)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(4)
                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                    }
                    .frame(width: 50)

                    // Space bar
                    SpaceKeyButton2(key: "␣", color: Color.orange.opacity(0.2), onKeyPress: onKeyPress, isShifted: .constant(false))
                        .frame(maxWidth: .infinity)
                    
                    Button(action: {
                        onKeyPress("⏎")
                    }) {
                        Text("⏎")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(isShifted ? .blue : .gray)
                            .frame(height: 45)
                            .frame(minWidth: 45)
                            .background(isShifted ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                            .cornerRadius(4)
                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                    }
                    .frame(width: 50)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal , 5)
            }
        }
        .padding(.vertical,10)
        .background(Color.gray.opacity(0.3))
    }
}
// Regular key button
struct KeyButton2: View {
    let key: String
    let color: Color
    let onKeyPress: (String) -> Void
    @Binding var isShifted: Bool
    
    var body: some View {
        Button(action: {
            onKeyPress(key)
            // If shift is on and this is a letter, turn off shift after typing
            if isShifted && key.rangeOfCharacter(from: .letters) != nil {
                isShifted = false
            }
        }) {
            Text(key)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.black)
                .frame(height: 45)
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
    
    var body: some View {
        Button(action: {
            onKeyPress(key)
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
    
    var body: some View {
        Button(action: {
            onKeyPress(key)
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


