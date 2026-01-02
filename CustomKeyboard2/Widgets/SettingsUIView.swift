//
//  SettingsUIView.swift
//  CustomKeyboard2
//
//  Created by Aryan Jaiswal on 31/12/25.
//

import SwiftUI

struct SettingsUIView: View {
    
    @Binding var showSettings: Bool
    @ObservedObject var themeManager: ThemeManager
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack(alignment: .center){
                
                Button{
                    showSettings = false
                }label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 12, height: 20)
                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                }
                
                Text("Settings")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                    .padding(.leading, 12)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.horizontal)
            
            HStack{
                VStack(alignment: .center){
                    Image(systemName: "sun.max.fill")
                        .resizable()
                        .frame(width: 20,height: 20)
                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                    
                    Text("Themes")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                        .padding(.leading,4)
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(themeManager.currentTheme.specialKeyBackground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .frame(height: 50)
                
                Button{
                    
                }label: {
                    
                    VStack(alignment: .center){
                        Image(systemName: "gear")  //checkmark.circle for Auto Correction
                            .resizable()
                            .frame(width: 20,height: 20)
                            .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                        
                        Text("Settings")
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                            .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                            .padding(.leading,7)
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(themeManager.currentTheme.specialKeyBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .frame(height: 50)
                }
                VStack(alignment: .center){
                    Image(systemName: "text.bubble")
                        .resizable()
                        .frame(width: 20,height: 20)
                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                    
                    Text("Language")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                        .padding(.leading,10)
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(themeManager.currentTheme.specialKeyBackground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .frame(height: 50)
            }
            .padding(.horizontal)
            .padding(.top,15)
            
            
            //            HStack(alignment: .center){
            //                VStack{
            //                    Image(systemName: "lock.shield")
            //                        .resizable()
            //                        .frame(width: 20,height: 20)
            //                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
            //
            //                    Text("Privacy")
            //                        .font(.system(size: 16))
            //                        .fontWeight(.medium)
            //                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
            //                        .padding(.leading,4)
            //                }
            //                .padding(10)
            //                .frame(maxWidth: .infinity)
            //                .background(themeManager.currentTheme.specialKeyBackground)
            //                .clipShape(RoundedRectangle(cornerRadius: 12))
            //                .frame(height: 50)
            //
            //                VStack{
            //                    Image(systemName: "gear")
            //                        .resizable()
            //                        .frame(width: 20,height: 20)
            //                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
            //
            //                    Text("Settings")
            //                        .font(.system(size: 16))
            //                        .fontWeight(.medium)
            //                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
            //                        .padding(.leading,4)
            //                }
            //                .padding(10)
            //                .frame(maxWidth: .infinity)
            //                .background(themeManager.currentTheme.specialKeyBackground)
            //                .clipShape(RoundedRectangle(cornerRadius: 12))
            //                .frame(height: 50)
            //
            //                VStack{
            //                    Image(systemName: "info.circle")
            //                        .resizable()
            //                        .frame(width: 20,height: 20)
            //                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
            //
            //                    Text("About")
            //                        .font(.system(size: 16))
            //                        .fontWeight(.medium)
            //                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
            //                        .padding(.leading,4)
            //                }
            //                .padding(10)
            //                .frame(maxWidth: .infinity)
            //                .background(themeManager.currentTheme.specialKeyBackground)
            //                .clipShape(RoundedRectangle(cornerRadius: 12))
            //                .frame(height: 50)
            //
            //            }
            //            .padding(.horizontal)
            //            .padding(.top,20)
            
            // Theme Selection Section
            //            Text("Choose Theme")
            //                .font(.system(size: 18))
            //                .fontWeight(.medium)
            //                .foregroundStyle(themeManager.currentTheme.primaryTextColor)
            //                .padding(.top, 25)
            //                .padding(.horizontal)
            
            HStack(spacing: 12) {
                ForEach(themeManager.getThemeNames(), id: \.self) { themeName in
                    Button(action: {
                        themeManager.setTheme(themeName)
                    }) {
                        VStack(spacing: 8) {
                            // Theme preview
                            RoundedRectangle(cornerRadius: 8)
                                .fill(themeManager.availableThemes[themeName]!.keyboardBackground)
                                .frame(width: 50, height: 50)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(themeManager.availableThemes[themeName]!.primaryKeyBackground)
                                        .frame(width: 35, height: 25)
                                        .overlay(
                                            Text("A")
                                                .font(.system(size: 14))
                                                .foregroundColor(themeManager.availableThemes[themeName]!.primaryTextColor)
                                        )
                                )
                            
                            Text(themeName)
                                .font(.system(size: 12))
                                .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                                .lineLimit(1)
                            
                            if themeManager.getThemeNames().first(where: { themeManager.availableThemes[$0]!.keyboardBackground == themeManager.currentTheme.keyboardBackground }) == themeName {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(themeManager.currentTheme.accentColor)
                                    .font(.system(size: 16))
                            } else {
                                Circle()
                                    .fill(Color.clear)
                                    .frame(height: 16)
                            }
                        }
                        .frame(width: 80)
                        .padding(.vertical, 8)
                        .background(themeManager.currentTheme.specialKeyBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
        .background(themeManager.currentTheme.keyboardBackground)
    }
}

#Preview {
    SettingsUIView(showSettings: .constant(false), themeManager: ThemeManager())
}
