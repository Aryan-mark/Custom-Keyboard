//
//  ContentView.swift
//  Keyboard
//
//  Created by Aryan Jaiswal on 24/12/25.
//

import SwiftUI

struct ContentView: View {
    @State var string: String = ""
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
//            TextField("Enter", text: $string)
//                .padding()
//                .frame(width: .infinity, height: 45)
//                .foregroundStyle(.white)
//                .background(.gray.opacity(0.5))
//                .border(Color.gray, width: 1)
//                .keyboardType(.namePhonePad)
//                .padding(.top,10)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
