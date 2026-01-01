//
//  SymbolPopUpViewUIView.swift
//  CustomKeyboard2
//
//  Created by Aryan Jaiswal on 31/12/25.
//

import SwiftUI

struct SymbolPopUpViewUIView: View {
    
    @Binding var showPeriodPopup: Bool
    let onKeyPress: (String) -> (Void)
    let popUpSymbol = [".", ",", "?", "$"]
    
    var body: some View {

            ZStack {
                Color.black.opacity(0.01)
                    .onTapGesture {
                        showPeriodPopup = false
                    }
                // Popup content
                HStack(spacing: 4) {
                    ForEach(popUpSymbol, id: \.self) { char in
                        Button(action: {
                            onKeyPress(char)
                            showPeriodPopup = false
                        }) {
                            Text(char)
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.black)
                                .frame(width: 36, height: 44)
                                .background(Color.pink.opacity(0.2))
                                .cornerRadius(4)
                                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                        }
                    }
                }
                .padding(8)
                .background(Color.white)
                .cornerRadius(12)
            }

    }
}

#Preview {
    SymbolPopUpViewUIView(showPeriodPopup: .constant(false), onKeyPress: {key in print(key)})
}
