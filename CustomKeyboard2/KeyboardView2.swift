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
    
    let color = Color.backgroundKeyboard
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
    let popUpSymbol = [".", ",", "?", "$"]
    
    // Comprehensive iPhone emoji dataset
    let emojis: [[String]] = [
        // Smileys & People
        ["😀", "😃", "😄", "😁", "😆", "😅", "🤣", "😂", "🙂", "🙃", "😉", "😊", "😇", "🥰", "😍", "🤩", "😘", "😗", "☺️", "😚", "😙", "🥲", "😋", "😛", "😜", "🤪", "😝", "🤑", "🤗", "🤭", "🤫", "🤔", "🤐", "🤨", "😐", "😑", "😶", "😏", "😒", "🙄", "😬", "🤥", "😔", "😪", "🤤", "😴", "😷", "🤒", "🤕", "🤢", "🤮", "🤧", "🥵", "🥶", "🥴", "😵", "🤯", "🤠", "🥳", "🥸", "😎", "🤓", "🧐", "😕", "😟", "🙁", "☹️", "😮", "😯", "😲", "😳", "🥺", "😦", "😧", "😨", "😰", "😥", "😢", "😭", "😱", "😖", "😣", "😞", "😓", "😩", "😫", "🥱", "😤", "😡", "😠", "🤬", "😈", "👿", "💀", "☠️", "💩", "🤡", "👹", "👺", "👻", "👽", "👾", "🤖", "😺", "😸", "😹", "😻", "😼", "😽", "🙀", "😿", "😾"],
        
        // People & Gestures
        ["👋", "🤚", "🖐️", "✋", "🖖", "👌", "🤌", "🤏", "✌️", "🤞", "🤟", "🤘", "🤙", "👈", "👉", "👆", "🖕", "👇", "☝️", "👍", "👎", "👊", "✊", "🤛", "🤜", "👏", "🙌", "👐", "🤲", "🤝", "🙏", "✍️", "💅", "🤳", "💪", "🦾", "🦿", "🦵", "🦶", "👂", "🦻", "👃", "🧠", "🫀", "🫁", "🦷", "🦴", "👀", "👁️", "👅", "👄", "👶", "🧒", "👦", "👧", "🧑", "👱", "👨", "🧔", "👩", "🧓", "👴", "👵", "🙍", "🙎", "🙅", "🙆", "💁", "🙋", "🧏", "🙇", "🤦", "🤷", "👮", "🕵️", "💂", "🥷", "👷", "🤴", "👸", "👳", "👲", "🧕", "🤵", "🤰", "🤱", "👼", "🎅", "🤶", "🦸", "🦹", "🧙", "🧚", "🧛", "🧜", "🧝", "🧞", "🧟", "💆", "💇", "🚶", "🧍", "🧎", "👨‍🦯", "👩‍🦯", "👨‍🦼", "👩‍🦼", "👨‍🦽", "👩‍🦽", "🏃", "💃", "🕺", "🕴️", "👯", "🧖", "🧗", "🤺", "🏇", "⛷️", "🏂", "🏌️", "🏄", "🚣", "🏊", "⛹️", "🏋️", "🚴", "🚵", "🤼", "🤽", "🤹", "🧘", "🛀", "🛌"],
        
        // Animals & Nature
        ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐽", "🐸", "🐵", "🙈", "🙉", "🙊", "🐒", "🐔", "🐧", "🐦", "🐤", "🐣", "🐥", "🦆", "🦅", "🦉", "🦇", "🐺", "🐗", "🐴", "🦄", "🐝", "🐛", "🦋", "🐌", "🐞", "🐜", "🦗", "🕷️", "🦂", "🐢", "🐍", "🦎", "🦖", "🦕", "🐙", "🦑", "🦐", "🦞", "🦀", "🐡", "🐠", "🐟", "🐬", "🐳", "🐋", "🦈", "🐊", "🐅", "🐆", "🦓", "🦍", "🦧", "🐘", "🦛", "🦏", "🐪", "🐫", "🦒", "🦘", "🐃", "🐂", "🐄", "🐎", "🐖", "🐏", "🐑", "🦙", "🐐", "🦌", "🐕", "🐩", "🦮", "🐕‍🦺", "🐈", "🐈‍⬛", "🐓", "🦃", "🦚", "🦜", "🦢", "🦩", "🕊️", "🐇", "🦝", "🦨", "🦡", "🦦", "🦥", "🐁", "🐀", "🐿️", "🦔", "🐾", "🐉", "🐲", "🌵", "🎄", "🌲", "🌳", "🌴", "🪵", "🌱", "🌿", "☘️", "🍀", "🎋", "🎍", "🌾", "🌸", "🌺", "🌻", "🌷", "🌹", "🥀", "🌼", "🍄", "🌰"],
        
        // Food & Drink
        ["🍎", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍅", "🍆", "🥑", "🥦", "🥬", "🥒", "🌶️", "🫑", "🌽", "🥕", "🫒", "🧄", "🧅", "🥔", "🍠", "🥐", "🥖", "🍞", "🥨", "🥯", "🧀", "🥚", "🍳", "🧈", "🥞", "🧇", "🥓", "🥩", "🍗", "🍖", "🦴", "🌭", "🍔", "🍟", "🍕", "🫓", "🥙", "🌮", "🌯", "🫔", "🥗", "🥘", "🫕", "🍝", "🍜", "🍲", "🍛", "🍣", "🍱", "🥟", "🦪", "🍤", "🍙", "🍚", "🍘", "🍥", "🥠", "🥮", "🍢", "🍡", "🍧", "🍨", "🍦", "🥧", "🧁", "🍰", "🎂", "🍮", "🍭", "🍬", "🍫", "🍿", "🍩", "🍪", "🌰", "🥜", "🍯", "🥛", "🍼", "☕", "🫖", "🍵", "🧃", "🥤", "🧋", "🍶", "🍺", "🍻", "🥂", "🍷", "🥃", "🍸", "🍹", "🧉", "🍾"],
        
        // Activities & Sports
        ["⚽", "🏀", "🏈", "⚾", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓", "🏸", "🏒", "🏑", "🥍", "🏏", "🪃", "🥅", "⛳", "🪁", "🏹", "🎣", "🤿", "🥊", "🥋", "🎽", "🛹", "🛷", "⛸️", "🥌", "🎿", "⛷️", "🏂", "🪂", "🏋️", "🤼", "🤸", "⛹️", "🤺", "🧘", "🏃", "🚶", "🧎", "🧍", "🤽", "🤾", "🏇", "🏊", "🚣", "🏄", "🚵", "🚴", "🎪", "🎭", "🩰", "🎨", "🎬", "🎤", "🎧", "🎼", "🎹", "🥁", "🪘", "🎷", "🎺", "🪗", "🎸", "🪕", "🎻", "🎲", "♠️", "♥️", "♦️", "♣️", "🃏", "🀄", "🎴", "🎯", "🎳", "🎮", "🕹️", "🎰", "🧩"],
        
        // Travel & Places
        ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🚚", "🚛", "🚜", "🏍️", "🛵", "🚲", "🛴", "🛹", "🚁", "🚟", "🚠", "🛤️", "🛣️", "🗺️", "⛽", "🚨", "🚥", "🚦", "🛑", "🚧", "⚓", "⛵", "🛶", "🚤", "🛳️", "⛴️", "🛥️", "🚢", "✈️", "🛩️", "🛫", "🛬", "🪂", "💺", "🚀", "🛸", "🚡", "🏔️", "⛰️", "🌋", "🗻", "🏕️", "🏖️", "🏜️", "🏝️", "🏞️", "🏟️", "🏛️", "🏗️", "🧱", "🏘️", "🏚️", "🏠", "🏡", "🏢", "🏣", "🏤", "🏥", "🏦", "🏨", "🏩", "🏪", "🏫", "🏬", "🏭", "🏯", "🏰", "💒", "🗼", "🗽", "⛪", "🕌", "🛕", "🕍", "⛩️", "🕋", "⛲", "⛺", "🌁", "🌃", "🏙️", "🌄", "🌅", "🌆", "🌇", "🌉", "♨️", "🎠", "🎡", "🎢", "💈", "🎪"],
        
        // Objects
        ["⌚", "📱", "📲", "💻", "⌨️", "🖥️", "🖨️", "🖱️", "🖲️", "🕹️", "🗜️", "💽", "💾", "💿", "📀", "📼", "📷", "📸", "📹", "🎥", "📽️", "🎞️", "📞", "☎️", "📟", "📠", "📺", "📻", "🎙️", "🎚️", "🎛️", "🧭", "⏱️", "⏲️", "⏰", "🕰️", "⌛", "⏳", "📡", "🔋", "🔌", "💡", "🔦", "🕯️", "🪔", "🧯", "🛢️", "💸", "💵", "💴", "💶", "💷", "💰", "💳", "💎", "⚖️", "🪜", "🧰", "🧲", "⚗️", "🧪", "🧫", "🧬", "🔬", "🔭", "💉", "🩸", "💊", "🩹", "🩼", "🩺", "🚪", "🪑", "🛋️", "🛏️", "🛌", "🚽", "🪠", "🚿", "🛁", "🪒", "🧴", "🧷", "🧹", "🧺", "🧽", "🧼", "🪣", "🪥"],
        
        // Symbols
        ["❤️", "🧡", "💛", "💚", "💙", "💜", "🖤", "🤍", "🤎", "💔", "❤️‍🔥", "❤️‍🩹", "💕", "💞", "💓", "💗", "💖", "💘", "💝", "💟", "☮️", "✝️", "☪️", "🕉️", "☸️", "✡️", "🔯", "🕎", "☯️", "☦️", "🛐", "⛎", "♈", "♉", "♊", "♋", "♌", "♍", "♎", "♏", "♐", "♑", "♒", "♓", "🆔", "⚛️", "🉑", "☢️", "☣️", "📴", "📳", "🈶", "🈚", "🈸", "🈺", "🈷️", "✴️", "🆚", "💮", "🉐", "㊙️", "㊗️", "🈴", "🔞", "📵", "🚳", "🚭", "🚯", "🚱", "🚷", "♿", "🅿️", "🈂️", "🛂", "🛃", "🛄", "🛅", "⚠️", "🚸", "⛔", "🚫", "⬆️", "↗️", "➡️", "↘️", "⬇️", "↙️", "⬅️", "↖️", "↕️", "↔️", "↩️", "↪️", "⤴️", "⤵️", "🔃", "🔄", "🔙", "🔚", "🔛", "🔜", "🔝", "🔀", "🔁", "🔂", "▶️", "⏩", "⏭️", "⏯️", "◀️", "⏪", "⏮️", "🔼", "⏫", "🔽", "⏬", "⏸️", "⏹️", "⏺️", "⏏️", "🎦", "🔅", "🔆", "📶", "📳", "📴", "♀️", "♂️", "⚧️", "✖️", "➕", "➖", "➗", "🟰", "♾️", "‼️", "⁉️", "❓", "❔", "❕", "❗", "〰️", "💱", "💲", "⚕️", "♻️", "⚜️", "🔱", "📛", "🔰", "⭕", "✅", "☑️", "✔️", "❌", "❎", "➰", "➿", "〽️", "✳️", "✴️", "❇️", "©️", "®️", "™️", "🔟", "🔢"],
        
        // Flags
        ["🏁", "🚩", "🎌", "🏴", "🏳️", "🏳️‍🌈", "🏳️‍⚧️", "🏴‍☠️", "🇦🇫", "🇦🇱", "🇩🇿", "🇦🇸", "🇦🇩", "🇦🇴", "🇦🇮", "🇦🇶", "🇦🇬", "🇦🇷", "🇦🇲", "🇦🇼", "🇦🇺", "🇦🇹", "🇦🇿", "🇧🇸", "🇧🇭", "🇧🇩", "🇧🇧", "🇧🇾", "🇧🇪", "🇧🇿", "🇧🇯", "🇧🇲", "🇧🇹", "🇧🇴", "🇧🇦", "🇧🇼", "🇧🇷", "🇧🇳", "🇧🇬", "🇧🇫", "🇧🇮", "🇰🇭", "🇨🇲", "🇨🇦", "🇨🇻", "🇰🇾", "🇨🇫", "🇹🇩", "🇨🇱", "🇨🇳", "🇨🇴", "🇰🇲", "🇨🇬", "🇨🇩", "🇨🇰", "🇨🇷", "🇭🇷", "🇨🇺", "🇨🇾", "🇨🇿", "🇩🇰", "🇩🇯", "🇩🇲", "🇩🇴", "🇪🇨", "🇪🇬", "🇸🇻", "🇬🇶", "🇪🇷", "🇪🇪", "🇸🇿", "🇪🇹", "🇫🇰", "🇫🇴", "🇫🇯", "🇫🇮", "🇫🇷", "🇬🇫", "🇵🇫", "🇹🇫", "🇬🇦", "🇬🇲", "🇬🇪", "🇩🇪", "🇬🇭", "🇬🇮", "🇬🇷", "🇬🇱", "🇬🇩", "🇬🇵", "🇬🇺", "🇬🇹", "🇬🇬", "🇬🇳", "🇬🇼", "🇬🇾", "🇭🇹", "🇭🇳", "🇭🇰", "🇭🇺", "🇮🇸", "🇮🇳", "🇮🇩", "🇮🇷", "🇮🇶", "🇮🇪", "🇮🇲", "🇮🇱", "🇮🇹", "🇨🇮", "🇯🇲", "🇯🇵", "🇯🇪", "🇯🇴", "🇰🇿", "🇰🇪", "🇰🇮", "🇰🇵", "🇰🇷", "🇰🇼", "🇰🇬", "🇱🇦", "🇱🇻", "🇱🇧", "🇱🇸", "🇱🇷", "🇱🇾", "🇱🇮", "🇱🇹", "🇱🇺", "🇲🇴", "🇲🇰", "🇲🇬", "🇲🇼", "🇲🇾", "🇲🇻", "🇲🇱", "🇲🇹", "🇲🇭", "🇲🇶", "🇲🇷", "🇲🇺", "🇾🇹", "🇲🇽", "🇫🇲", "🇲🇩", "🇲🇨", "🇲🇳", "🇲🇪", "🇲🇸", "🇲🇦", "🇲🇿", "🇲🇲", "🇳🇦", "🇳🇷", "🇳🇵", "🇳🇱", "🇳🇨", "🇳🇿", "🇳🇮", "🇳🇪", "🇳🇬", "🇳🇺", "🇳🇫", "🇲🇵", "🇳🇴", "🇴🇲", "🇵🇰", "🇵🇼", "🇵🇸", "🇵🇦", "🇵🇬", "🇵🇾", "🇵🇪", "🇵🇭", "🇵🇳", "🇵🇱", "🇵🇹", "🇵🇷", "🇶🇦", "🇷🇪", "🇷🇴", "🇷🇺", "🇷🇼", "🇼🇸", "🇸🇲", "🇸🇹", "🇸🇦", "🇸🇳", "🇷🇸", "🇸🇨", "🇸🇱", "🇸🇬", "🇸🇰", "🇸🇮", "🇸🇧", "🇸🇴", "🇿🇦", "🇬🇸", "🇪🇸", "🇱🇰", "🇸🇩", "🇸🇷", "🇸🇯", "🇸🇪", "🇨🇭", "🇸🇾", "🇹🇼", "🇹🇯", "🇹🇿", "🇹🇭", "🇹🇱", "🇹🇬", "🇹🇰", "🇹🇴", "🇹🇹", "🇹🇳", "🇹🇷", "🇹🇲", "🇹🇨", "🇹🇻", "🇻🇮", "🇺🇬", "🇺🇦", "🇦🇪", "🇬🇧", "🇺🇸", "🇺🇾", "🇺🇿", "🇻🇺", "🇻🇦", "🇻🇪", "🇻🇳", "🇻🇬", "🇼🇫", "🇪🇭", "🇾🇪", "🇿🇲", "🇿🇼"]
    ]
    
    var topRow: [String] {
        switch keyboardMode {
        case .letters:
            return isShifted ? topCapsCharacter : topSmallCharacter
        case .numbers:
            return numberRow
        case .symbols:
            return symbolRow1
        case .emojis:
            return []
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
        case .emojis:
            return []
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
        case .emojis:
            return []
        }
    }
    
    // Period popup view
    var periodPopupView: some View {
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
            .padding(12)
            .background(Color.white)
            .cornerRadius(12)
            .offset(x:40, y: -70) // Position above the button
        }
    }
    
    // Emoji View
    var emojiView: some View {
        VStack(spacing: 5) {
            // Horizontal scrolling emoji rows
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: Array(repeating: GridItem(.flexible()), count: 5), spacing: 5) {
                    ForEach(emojis.flatMap { $0 }, id: \.self) { emoji in
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
                                KeyButton2(key: key, color: Color.pink.opacity(0.2), onKeyPress: onKeyPress, isShifted: keyboardMode == .letters ? $isShifted : .constant(false), showPeriodPopup: $showPeriodPopup)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, keyboardMode == .letters ? 5 : 5)
                        
                        // Middle row (ASDF...)
                        HStack(spacing: 4) {
                            ForEach(middleRow, id: \.self) { key in
                                KeyButton2(key: key,color: Color.pink.opacity(0.2), onKeyPress: onKeyPress, isShifted: $isShifted,showPeriodPopup: $showPeriodPopup)
                            }
                        }
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.horizontal,20)
                        
                        // Bottom row
                        HStack(spacing: 4) {
                            if keyboardMode == .letters {
                                Button(action: {
                                    isShifted.toggle()
                                    showPeriodPopup = false
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
                            HStack(spacing: 4) {
                                ForEach(bottomRow, id: \.self) { key in
                                    KeyButton2(key: key, color: Color.pink.opacity(0.2), onKeyPress: onKeyPress, isShifted: keyboardMode == .letters ? $isShifted : .constant(false), showPeriodPopup: $showPeriodPopup)
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
                            // Cycling mode button for letters/numbers/symbols
                            Button(action: {
                                switch keyboardMode {
                                case .letters:
                                    keyboardMode = .numbers
                                case .numbers:
                                    keyboardMode = .symbols
                                case .symbols:
                                    keyboardMode = .letters
                                case .emojis:
                                    keyboardMode = .letters
                                }
                                showPeriodPopup = false
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
                                    periodPopupView
                                        .zIndex(0) // Ensure popup appears above other elements
                                }
                            }
                            .frame(maxWidth: 36)
                            .padding(.leading,4)
                            
                            // Space bar
                            SpaceKeyButton2(key: "␣", color: Color.orange.opacity(0.2), onKeyPress: onKeyPress, isShifted: .constant(false), showPeriodPopup: $showPeriodPopup)
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


