//
//  KeyboardView.swift
//  Keyboard
//
//  Created by Aryan Jaiswal on 24/12/25.
//

import SwiftUI

struct KeyboardView: View {
    let onKeyPress: (String) -> Void
    
    @State private var isShifted = false
    
    // Keyboard layout
    let numberRow = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    
    var topRow: [String] {
        isShifted ? ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"] : ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"]
    }
    
    var middleRow: [String] {
        isShifted ? ["A", "S", "D", "F", "G", "H", "J", "K", "L"] : ["a", "s", "d", "f", "g", "h", "j", "k", "l"]
    }
    
    var bottomRow: [String] {
        isShifted ? ["Z", "X", "C", "V", "B", "N", "M"] : ["z", "x", "c", "v", "b", "n", "m"]
    }
    
    var body: some View {
        ZStack {
            // Keyboard background color
            Color.gray.opacity(0.2)
                .ignoresSafeArea()
            
            VStack(spacing: 8) {
                // Number row
                HStack(spacing: 4) {
                    ForEach(numberRow, id: \.self) { key in
                        KeyButton( key: key,color: Color.white, onKeyPress: onKeyPress, isShifted: .constant(false))
                    }
                }
                
                // Top row (QWERTY...)
                HStack(spacing: 4) {
                    ForEach(topRow, id: \.self) { key in
                        KeyButton(key: key,color: Color.blue.opacity(0.5), onKeyPress: onKeyPress, isShifted: $isShifted)
                    }
                }
                
                // Middle row (ASDF...)
                HStack(spacing: 4) {
                    Spacer().frame(width: 20) // Offset for center alignment
                    ForEach(middleRow, id: \.self) { key in
                        KeyButton(key: key,color: Color.blue.opacity(0.5), onKeyPress: onKeyPress, isShifted: $isShifted)
                    }
                    Spacer().frame(width: 20)
                }
                
                // Bottom row (ZXCV...) + special keys
                HStack(spacing: 4) {
                    // Shift key
                    Button(action: {
                        isShifted.toggle()
                    }) {
                        Text("⇧")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(isShifted ? .blue : .gray)
                            .frame(height: 40)
                            .frame(minWidth: 40)
                            .background(isShifted ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                            .cornerRadius(4)
                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                    }
                    .frame(width: 50)
                    
                    // Bottom row letters
                    HStack(spacing: 4) {
                        ForEach(bottomRow, id: \.self) { key in
                            KeyButton(key: key,color: Color.blue.opacity(0.5), onKeyPress: onKeyPress, isShifted: $isShifted)
                        }
                    }
                    
                    // Backspace key
                    SpecialKeyButton(key: "⌫",color: Color.gray.opacity(0.2),  onKeyPress: onKeyPress)
                        .frame(width: 50)
                }
                
                // Space bar and return row
                HStack(spacing: 4) {
                    Spacer().frame(width: 0)
                    HStack(spacing: -11) {
                        // Return key
                        SpecialKeyButton(key: "⏎",color: Color.gray.opacity(0.2), onKeyPress: onKeyPress)
                            .frame(width: 80)
                        
                        KeyButton(key: ".",color: Color.blue.opacity(0.5), onKeyPress: onKeyPress, isShifted: .constant(false))
                    }
                    
                    // Space bar
                    SpaceKeyButton(key: "␣", color: Color.gray.opacity(0.2), onKeyPress: onKeyPress, isShifted: .constant(false))
                        .frame(maxWidth: .infinity)
                    
                    // Period and comma
                    KeyButton(key: ",",color: Color.blue.opacity(0.5), onKeyPress: onKeyPress, isShifted: .constant(false))
                    Spacer().frame(width: 20)
                }
            }
            .padding(.horizontal, 4)
            .padding(.vertical, 8)
        }
    }
}
// Regular key button
struct KeyButton: View {
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
                .frame(height: 40)
                .frame(minWidth: 32)
                .background(color)
                .cornerRadius(4)
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
        }
    }
}

struct SpaceKeyButton: View {
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
                .frame(maxWidth: .infinity, maxHeight:  40)
                .background(color)
                .cornerRadius(4)
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
        }
    }
}

// Special key button (for backspace, shift, return, etc.)
struct SpecialKeyButton: View {
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
    KeyboardView(onKeyPress: { key in
        print("Key pressed: \(key)")
    })
}


