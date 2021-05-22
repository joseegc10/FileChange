//
//  MenuView.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 4/5/21.
//

import SwiftUI

struct MenuView: View {
    @StateObject var files = FileViewModel()
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.black
    }
    
    var body: some View {
        TabView {
            InitView()
                .tabItem {
                    Label("Inicio", systemImage: "house")
                }
            
            BuscarView()
                .tabItem {
                    Label("Buscar", systemImage: "magnifyingglass")
                }
            
            AddEditFileView()
                .tabItem {
                    Label("Añadir", systemImage: "plus")
                }
            
            AccountView()
                .tabItem {
                    Label("Cuenta", systemImage: "person")
                }

        }.accentColor(Color("itemTabBar"))
    }
}
