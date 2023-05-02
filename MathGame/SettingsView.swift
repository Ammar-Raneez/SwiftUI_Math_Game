//
//  SettingsView.swift
//  Assessment
//
//  Created by Visal Rajapakse on 2023-03-20.
//

import SwiftUI

enum SystemColor: String {
    case sapphire = "Sapphire"
    case ruby = "Ruby"
    case emerald = "Emerald"
}

struct SettingsView: View {
    @AppStorage("fontSize") var fontSize = 14.0
    @AppStorage("systemColor") var systemColor = SystemColor.emerald
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Font size (\(fontSize, specifier: "%.1f")px)")
                    .font(.system(size: CGFloat(fontSize)))
                    
                Slider(value: $fontSize, in: 14...30)
                    .accentColor(Color(systemColor.rawValue))
                
                VStack {
                    HStack {
                        Text("System color")
                        Picker("", selection: $systemColor) {
                            Text(SystemColor.sapphire.rawValue).tag(SystemColor.sapphire)
                            Text(SystemColor.ruby.rawValue).tag(SystemColor.ruby)
                            Text(SystemColor.emerald.rawValue).tag(SystemColor.emerald)
                        }
                        .pickerStyle(.wheel)
                        Rectangle()
                            .foregroundColor(Color(systemColor.rawValue))
                            .frame(width: 30, height: 30)
                    }
                    
                }
                
            }
            .navigationTitle(Text("Settings"))
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
