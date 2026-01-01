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
                
                Text("Settings")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundStyle(.black)
                    .padding(.leading, 12)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.horizontal)
            
            HStack{
                VStack(alignment: .center){
                    Image(systemName: "sun.max.fill")
                        .resizable()
                        .frame(width: 20,height: 20)
                        .foregroundStyle(.black)
                    
                    Text("Themes")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .padding(.leading,4)
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .frame(height: 50)
                
                VStack(alignment: .center){
                    Image(systemName: "checkmark.circle")
                        .resizable()
                        .frame(width: 20,height: 20)
                        .foregroundStyle(.black)
                    
                    Text("Auto Correction")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .padding(.leading,7)
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .frame(height: 50)
                
                VStack(alignment: .center){
                    Image(systemName: "text.bubble")
                        .resizable()
                        .frame(width: 20,height: 20)
                        .foregroundStyle(.black)
                    
                    Text("Language")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .padding(.leading,10)
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .frame(height: 50)
            }
            .padding(.horizontal)
            .padding(.top,15)
            
            
            HStack(alignment: .center){
                VStack{
                    Image(systemName: "lock.shield")
                        .resizable()
                        .frame(width: 20,height: 20)
                        .foregroundStyle(.black)
                    
                    Text("Privacy")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .padding(.leading,4)
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .frame(height: 50)
                
                VStack{
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 20,height: 20)
                        .foregroundStyle(.black)
                    
                    Text("Settings")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .padding(.leading,4)
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .frame(height: 50)
                
                VStack{
                    Image(systemName: "info.circle")
                        .resizable()
                        .frame(width: 20,height: 20)
                        .foregroundStyle(.black)
                    
                    Text("About")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .padding(.leading,4)
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .frame(height: 50)
                
            }
            .padding(.horizontal)
            .padding(.top,20)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
    }
}

#Preview {
    SettingsUIView(showSettings: .constant(false))
}
