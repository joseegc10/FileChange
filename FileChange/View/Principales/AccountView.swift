//
//  AccountView.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 4/5/21.
//

import SwiftUI

struct AccountView: View {
    @State var person = UserModel()
    @StateObject var archivos = FileViewModel()

    @EnvironmentObject var estado: FirebaseAuth
    
    @State private var misArchivos = false
    @State private var misDescargas = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("navBar").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                ScrollView {
                    VStack(alignment: .leading, spacing: 15){
                        
                        HStack(spacing: 40) {
                            Image(systemName: "person")
                                .resizable()
                                .frame(width: 70, height: 70, alignment: .leading)
                                .foregroundColor(.white)
                                .padding(.trailing)
                            
                            VStack(spacing: 10){
                                Text(archivos.user.nombre + " " + archivos.user.apellidos)
                                
                                Text(archivos.user.correo)
                                
                                Button(action:{
                                    UserDefaults.standard.removeObject(forKey: "logueado")
                                    estado.estado = .login
                                }){
                                    Text("Cerrar sesion")
                                        .foregroundColor(Color("itemTabBar"))
                                }
                            }.foregroundColor(.white)
                        }.frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical)
                        .background(Color("navBarFuerte"))
                        .modifier(CardModifier())
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color("navBar"), lineWidth: 0)
                        )
                        .padding(.all, 10)
                        
                        VStack(alignment: .leading, spacing: -2){
                            VStack(alignment: .leading, spacing: 8){
                                Button(action:{
                                    misArchivos = true
                                }){
                                    MyNavigationView(texto: "Mis archivos")
                                }
                                
                                ScrollFilesView(files: archivos.misArchivos)
                            }
                            
                            VStack(alignment: .leading, spacing: 8){
                                Button(action:{
                                    misDescargas = true
                                }){
                                    MyNavigationView(texto: "Mis descargas")
                                }
                                
                                ScrollFilesView(files: archivos.misDescargas)
                            }
                            
                            NavigationLink("", destination: ListaFilesView(misArchivos: .archivos), isActive: $misArchivos)
                            NavigationLink("", destination: ListaFilesView(misArchivos: .descargas), isActive: $misDescargas)
                            
                            
                        }
                    }
                    .navigationBarTitle("Cuenta", displayMode: .inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            HStack {
                                Text("Cuenta").font(.headline).foregroundColor(Color.white)
                            }
                        }
                    }
                    .onAppear{
                        archivos.getUserInfo()
                        archivos.getUserFiles()
                        archivos.getUserDownloads()
                    }
                }
            }
            }
            
    }
}


struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
    }
}
