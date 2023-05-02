//
//  MainTabView.swift
//  Assessment
//
//  Created by Visal Rajapakse on 2023-03-20.
//

import SwiftUI

struct MainTabView: View {
    @AppStorage("systemColor") var systemColor = SystemColor.emerald
        
    var body: some View {
        TabView {
            GameView()
                .tabItem {
                    Label("Guess", systemImage: "checkmark.circle.badge.questionmark.fill")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear.circle.fill")
                }
        }
        .tint(Color(systemColor.rawValue))
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
