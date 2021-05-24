//
//  ValoracionesView.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 11/5/21.
//

import SwiftUI

struct ValoracionesView: View {
    @State private var miValoracion: Int = 0
    @State private var siguiente = false
    @State private var termina = false
    @State var listaFiles: [FileModel]
    @State private var siguienteFile = FileModel()
    @StateObject var files = FileViewModel()
    @EnvironmentObject var login: FirebaseAuth
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            ImagenStorageView(imageURL: listaFiles[0].dirPortada, anchura: 160, tipo: listaFiles[0].tipoArchivo)
            
            VStack(spacing: 20){
                Text(listaFiles[0].titulo)
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Text("Por " + listaFiles[0].nombreAutor)
                    .font(.title)
                    .foregroundColor(.blue)
                
                HStack {
                    ForEach(1..<6, id: \.self, content: { i in
                        if miValoracion < i {
                            Image(systemName: "star")
                                .font(.largeTitle)
                                .onTapGesture {
                                    miValoracion = i
                                }
                        } else {
                            Image(systemName: "star.fill")
                                .font(.largeTitle)
                                .onTapGesture {
                                    if miValoracion == i {
                                        miValoracion -= 1
                                    } else {
                                        miValoracion = i
                                    }
                                }
                        }
                    })
                }.foregroundColor(Color("gold"))
                
                Button(action:{
                    files.deleteFileValorar(idFile: listaFiles[0].id)
                    files.aniadeValoracion(idFile: listaFiles[0].id, valoracion: miValoracion)
                    
                    if listaFiles.count > 1 {
                        listaFiles.remove(at: 0)
                        siguienteFile = listaFiles[0]
                        siguiente = true
                    } else {
                        termina = true
                        login.estado = .logueado
                    }
                }){
                    if listaFiles.count > 1 {
                        Text("Siguiente valoración")
                            .font(.headline)
                            .foregroundColor(.white)
                    } else {
                        Text("Finalizar valoraciones")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                }
                
                NavigationLink("", destination: ValoracionesView(listaFiles: listaFiles), isActive: $siguiente)
                
                NavigationLink("", destination: MenuView(), isActive: $termina)
            }
            
            Spacer()
        }
    }
}
