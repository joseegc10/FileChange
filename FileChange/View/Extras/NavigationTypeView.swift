//
//  NavigationTypeView.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 11/5/21.
//

import SwiftUI

struct NavigationTypeView: View {
    @Binding var activar: Bool
    var tipo: String
    @StateObject var files = FileViewModel()
    
    var body: some View {
        VStack {
            Button(action:{
                activar = true
            }){
                MyNavigationView(texto: tipo)
            }
            
            ScrollFilesView(files: files.filesTipo[tipo]!)
            
            NavigationLink("", destination: TypeFileView(tipo: tipo), isActive: $activar)
        }.onAppear{
            files.busquedaFilesTipo(tipoBuscado: tipo){ termina in
                
            }
        }
    }
}
