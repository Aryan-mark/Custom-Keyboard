//
//  KeyboardView.swift
//  Keyboard
//
//  Created by Aryan Jaiswal on 24/12/25.
//

import SwiftUI

// Enum to represent different themes
enum KeyboardTheme {
    case light
    case dark
}

struct KeyboardView: View {
    @Binding var currentTheme: KeyboardTheme
    var insertTextAction: (String) -> Void
    
    var body: some View {
        VStack {
            // Switch theme button
            ThemeSwitchButton(currentTheme: $currentTheme)
            
            // Keyboard layout
            HStack {
                ForEach(["1", "2", "3", "4", "5", "6", "7", "8", "9"], id: \.self) { number in
                    Button(action: {
                        insertTextAction(number)
                    }) {
                        Text(number)
                            .font(.largeTitle)
                            .frame(width: 50, height: 50)
                            .background(currentTheme == .light ? Color.white : Color.black)
                            .foregroundColor(currentTheme == .light ? Color.black : Color.white)
                            .cornerRadius(10)
                            .padding(5)
                    }
                }
            }
            
            // Add Hindi Calendar or custom content here
            Text("Hindi Calendar Placeholder")
                .font(.subheadline)
                .foregroundColor(currentTheme == .light ? .black : .white)
        }
        .padding()
        .background(currentTheme == .light ? Color.white : Color.black)
    }
}

struct ThemeSwitchButton: View {
    @Binding var currentTheme: KeyboardTheme
    
    var body: some View {
        Button(action: {
            currentTheme = (currentTheme == .light) ? .dark : .light
        }) {
            Text("Switch Theme")
                .font(.title)
                .foregroundColor(currentTheme == .light ? .black : .white)
                .padding()
                .background(currentTheme == .light ? Color.white : Color.black)
                .cornerRadius(10)
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView(currentTheme: .constant(.light), insertTextAction: { _ in })
            .previewLayout(.sizeThatFits)
    }
}
