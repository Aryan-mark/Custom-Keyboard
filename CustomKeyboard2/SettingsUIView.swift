//
//  SettingsUIView.swift
//  CustomKeyboard2
//
//  Created by Aryan Jaiswal on 31/12/25.
//

import SwiftUI

struct SettingsUIView: View {
    
    @Binding var showSettings: Bool
    var body: some View {
        VStack(alignment: .leading){
            
            HStack(alignment: .center){
                
                Button{
                    showSettings = false
                }label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 12, height: 20)
                        .foregroundStyle(.black)
                }
                .padding(.horizontal)
                
                Text("Settings")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity,alignment: .leading)
            }
            .frame(maxWidth: .infinity,alignment: .top)
            
            HStack{
                Image(systemName: "sun.max.fill")
                    .resizable()
                    .frame(width: 22,height: 22)
                    .foregroundStyle(.black)
                
                Text("Themes")
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .foregroundStyle(.black)
                    .padding(.leading,4)
                
                
            }.padding(.horizontal)
                .padding(.top,7)
            HStack{
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .frame(width: 22,height: 22)
                    .foregroundStyle(.black)
                
                Text("Auto Correction")
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .foregroundStyle(.black)
                    .padding(.leading,7)
                
            }
            .padding(.horizontal)
            .padding(.top,7)
            
            HStack{
                Image(systemName: "text.bubble")
                    .resizable()
                    .frame(width: 22,height: 22)
                    .foregroundStyle(.black)
                
                Text("Language")
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .foregroundStyle(.black)
                    .padding(.leading,10)
                
            }.padding(.horizontal)
                .padding(.top,10)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
    }
}

#Preview {
    SettingsUIView(showSettings: .constant(false))
}
