//
//  TypeFileView.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 10/5/21.
//

import SwiftUI

struct TypeFileView: View {
    var tipo: String
    @StateObject var files = FileViewModel()
    @State private var titulo = ""
    @State private var isEditing = false
    
    var body: some View {
        ZStack {
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
                            files.busquedaFilesTipo(tipoBuscado: tipo) { termina in
                                if termina {
                                    files.actualizaFilesTipo(tipo: tipo)
                                }
                            }
                        } else {
                            files.busquedaFiles(nombreBuscado: titulo, tipoBuscado: tipo)
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
                    ForEach(files.files, id: \.self.id){ file in
                        FileCardView(file: file)
                    }
                }.onAppear{
                    files.busquedaFilesTipo(tipoBuscado: tipo) { termina in
                        if termina {
                            files.actualizaFilesTipo(tipo: tipo)
                        }
                    }
                }
            }.padding(.trailing)
        }
    }
}
