//
//  EmojisUIView.swift
//  CustomKeyboard2
//
//  Created by Aryan Jaiswal on 01/01/26.
//

import SwiftUI

struct Emojis: View {

    let utils = Utils()
    let onKeyPress: (String) -> Void
    @Binding var showPeriodPopup: Bool
    @ObservedObject var themeManager: ThemeManager
    
    var body: some View {
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
}

#Preview {
    Emojis(onKeyPress: {key in print(key)}, showPeriodPopup: .constant(false), themeManager: ThemeManager())
}
