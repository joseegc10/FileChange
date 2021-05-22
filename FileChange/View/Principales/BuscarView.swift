//
//  BuscarView.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 10/5/21.
//

import SwiftUI
import Firebase

struct BuscarView: View {
    @State private var nombre: String = ""
    @State private var tipo: String = "Libro"
    @StateObject var files = FileViewModel()
    
    @State private var isEditing = false
    
    @State private var miFile = FileModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("navBar").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                ScrollView {
                    VStack {
                        HStack {
                            TextField("Título", text: $nombre)
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
                                                self.nombre = ""
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
                                files.busquedaFiles(nombreBuscado: nombre, tipoBuscado: tipo)
                            }) {
                                Text("Buscar")
                                    .foregroundColor(.white)
                            }
                            .padding(.trailing, 10)
                            .transition(.move(edge: .trailing))
                            .animation(.default)
                        }.padding()
                    }
                    
                    HStack {
                        VStack{
                            TiposPickerView(selectedTitle: $tipo, tipoInicial: "Libro")
                        }
                    }
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 10){
                        ForEach(files.files, id: \.self.id){ file in
                            FileCardView(file: file)
                        }
                    }
                }.navigationBarTitle("Búsqueda", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text("Búsqueda").font(.headline).foregroundColor(Color.white)
                        }
                    }
                }
            }
            }
            
    }
}
