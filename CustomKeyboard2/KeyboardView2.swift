//
//  KeyboardView.swift
//  Keyboard
//
//  Created by Aryan Jaiswal on 24/12/25.
//

import SwiftUI

struct KeyboardView2: View {
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
//            Color.gray.opacity(0.2)
//                .ignoresSafeArea()
            
            VStack(alignment: .leading , spacing: 12) {
                // Number row
                //                HStack(spacing: 4) {
                //                    ForEach(numberRow, id: \.self) { key in
                //                        KeyButton2( key: key,color: Color.white, onKeyPress: onKeyPress, isShifted: .constant(false))
                //                    }
                //                }
                
                // Top row (QWERTY...)
                HStack(spacing: 5) {
                    ForEach(topRow, id: \.self) { key in
                        KeyButton2(key: key,color: Color.pink.opacity(0.2), onKeyPress: onKeyPress, isShifted: $isShifted)
                    }
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal,8)
                
                // Middle row (ASDF...)
                HStack(spacing: 4) {
                    ForEach(middleRow, id: \.self) { key in
                        KeyButton2(key: key,color: Color.pink.opacity(0.2), onKeyPress: onKeyPress, isShifted: $isShifted)
                    }
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal,25)
                
                // Bottom row (ZXCV...)
                HStack(spacing: 5) {
                    // Shift key
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
                    
                    Spacer().frame(width: 0)
                    // Bottom row letters
                    HStack(spacing: 5) {
                        ForEach(bottomRow, id: \.self) { key in
                            KeyButton2(key: key,color: Color.pink.opacity(0.2), onKeyPress: onKeyPress, isShifted: $isShifted)
                        }
                    }
                    Spacer().frame(width: 0)

                    Button(action: {
                        onKeyPress("⌫")
                    }) {
                        Text("⌫")
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
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal,5)
                
                // Space bar and return row
                HStack(spacing: 5) {
                    
                    Button(action: {
                        onKeyPress("123")
                    }) {
                        Text("123")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(isShifted ? .blue : .gray)
                            .frame(height: 45)
                            .frame(minWidth: 45)
                            .background(isShifted ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                            .cornerRadius(4)
                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                    }
                    .frame(width: 50)
                    
                    // Return key
//                    KeyButton2(key: ".",color: Color.pink.opacity(0.2), onKeyPress: onKeyPress, isShifted: .constant(false))
                    
                    
                    // Space bar
                    SpaceKeyButton2(key: "␣", color: Color.orange.opacity(0.2), onKeyPress: onKeyPress, isShifted: .constant(false))
                        .frame(maxWidth: .infinity)
                    
                    // Period and comma
//                    KeyButton2(key: ",",color: Color.pink.opacity(0.2), onKeyPress: onKeyPress, isShifted: .constant(false))
                    
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
//                    
//                    SpecialKeyButton2(key: "⏎",color: Color.gray.opacity(0.2), onKeyPress: onKeyPress)
//                        .frame(width: 80)
                    
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


