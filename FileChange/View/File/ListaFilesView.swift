//
//  ListaFilesView.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 11/5/21.
//

import SwiftUI

enum TipoLista {
    case archivos, descargas, recomendados
}

struct ListaFilesView: View {
    @State var misArchivos: TipoLista
    @StateObject var files = FileViewModel()
    @State private var titulo = ""
    @State private var isEditing = false
    
    var body: some View {
        ZStack{
            Color("navBar").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ScrollView {
                HStack {
                    TextField("Título", text: $titulo)
                        .disableAutocorrection(true)
                        .padding(7)
                        .padding(.horizontal, 25)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 8)
                         
                                if isEditing {
                                    Button(action: {
                                        self.titulo = ""
                                    }) {
                                        Image(systemName: "multiply.circle.fill")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                    }
                                }
                            }
                        )
                        .padding(.horizontal, 10)
                        .onTapGesture {
                            self.isEditing = true
                        }
         
                    Button(action: {
                        if titulo == "" {
                            if misArchivos == .archivos {
                                files.getUserFiles()
                            } else if misArchivos == .descargas {
                                files.getUserDownloads()
                            } else {
                                files.getFilesRecomendados()
                            }
                        } else {
                            if misArchivos == .archivos {
                                files.getUserFiles(cadena: titulo)
                            } else if misArchivos == .descargas {
                                files.getUserDownloads(cadena: titulo)
                            } else {
                                files.getFilesRecomendados(cadena: titulo)
                            }
                        }
                    }) {
                        Text("Buscar")
                            .foregroundColor(.white)
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                }.padding()

                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 10){
                    if misArchivos == .archivos {
                        ForEach(files.misArchivos, id: \.self.id){ file in
                            FileCardView(file: file)
                        }
                    } else if misArchivos == .descargas {
                        ForEach(files.misDescargas, id: \.self.id){ file in
                            FileCardView(file: file)
                        }
                    } else {
                        ForEach(files.filesRecomendados, id: \.self.id){ file in
                            FileCardView(file: file)
                        }
                    }
                    
                }.padding(.trailing)
                .onAppear{
                    if misArchivos == .archivos {
                        files.getUserFiles()
                    } else if misArchivos == .descargas {
                        files.getUserDownloads()
                    } else {
                        files.getFilesRecomendados()
                    }
                }
            }
        }
        
    }
}
