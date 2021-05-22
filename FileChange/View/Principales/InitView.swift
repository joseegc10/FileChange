//
//  InitView.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 14/5/21.
//

import SwiftUI

struct InitView: View {
    @Environment(\.presentationMode) var presentation
    let tiposPosibles: [String] = TipoFile.allCases.map{ $0.rawValue }
    @StateObject var files = FileViewModel()
    @State var libro = false
    @State var comic = false
    @State var poema = false
    @State var revista = false
    @State var apuntes = false
    @State var otro = false

    @State var activar: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("navBar").edgesIgnoringSafeArea(.all)
                
                ScrollView{
                    VStack{
                        Spacer()
                        VStack {
                            Button(action:{
                                activar = true
                            }){
                                MyNavigationView(texto: "Documentos recomendados")
                            }
                            
                            ScrollFilesView(files: files.filesRecomendados)
                            
                            NavigationLink("", destination: ListaFilesView(misArchivos: .recomendados), isActive: $activar)
                        }.onAppear{
                            files.getFilesRecomendados()
                        }
                    }
                    
                    VStack{
                        HStack{
                            Spacer()
                            
                            Button(action:{
                                libro = true
                            }){
                                VStack{
                                    Text("Libro")
                                        .foregroundColor(.white)
                                    ImagenStorageView(imageURL: "", anchura: 110, tipo: "Libro")
                                }
                            }
                            
                            Spacer()
                            
                            Button(action:{
                                comic = true
                            }){
                                VStack{
                                    Text("Comic")
                                        .foregroundColor(.white)
                                    ImagenStorageView(imageURL: "", anchura: 110, tipo: "Comic")
                                }
                            }
                            
                            Spacer()
                            
                            Button(action:{
                                poema = true
                            }){
                                VStack{
                                    Text("Poema")
                                        .foregroundColor(.white)
                                    ImagenStorageView(imageURL: "", anchura: 110, tipo: "Poema")
                                }
                            }
                            
                            Spacer()
                        }
                        
                        Spacer()
                        
                        HStack{
                            Spacer()
                            
                            Button(action:{
                                revista = true
                            }){
                                VStack{
                                    Text("Revista")
                                        .foregroundColor(.white)
                                    ImagenStorageView(imageURL: "", anchura: 110, tipo: "Revista")
                                }
                            }
                            
                            Spacer()
                            
                            Button(action:{
                                apuntes = true
                            }){
                                VStack{
                                    Text("Apuntes")
                                        .foregroundColor(.white)
                                    ImagenStorageView(imageURL: "", anchura: 110, tipo: "Apuntes")
                                }
                            }
                            
                            Spacer()
                            
                            Button(action:{
                                otro = true
                            }){
                                VStack{
                                    Text("Otro")
                                        .foregroundColor(.white)
                                    ImagenStorageView(imageURL: "", anchura: 110, tipo: "Otro")
                                }
                            }
                            
                            Spacer()
                        }
                    }
                    
                    NavigationLink("", destination: TypeFileView(tipo: "Libro"), isActive: $libro)
                    NavigationLink("", destination: TypeFileView(tipo: "Comic"), isActive: $comic)
                    NavigationLink("", destination: TypeFileView(tipo: "Poema"), isActive: $poema)
                    
                    NavigationLink("", destination: TypeFileView(tipo: "Revista"), isActive: $revista)
                    NavigationLink("", destination: TypeFileView(tipo: "Apuntes"), isActive: $apuntes)
                    NavigationLink("", destination: TypeFileView(tipo: "Otro"), isActive: $otro)
                }.navigationBarTitle("Inicio", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text("FileChange").font(.headline).foregroundColor(Color.white)
                        }
                    }
                }
            }
        }.navigationBarColor(backgroundColor: UIColor(Color("navBarFuerte")), tintColor: UIColor(Color.gray))
    }
}

