//
//  InitView.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 4/5/21.
//

import SwiftUI

func hola(){
    print("hola")
}

struct PrincipalView: View {
    @EnvironmentObject var login: FirebaseAuth
    @State private var listaFiles = [FileModel]()
    @StateObject var files = FileViewModel()
    
    var body: some View {
        ZStack {
            Color("navBar").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            if login.estado == .logueado {
                MenuView()
            } else if login.estado == .login {
                Color("navBar").edgesIgnoringSafeArea(.all)
                LoginView()
            } else if login.estado == .register {
                Color("navBar").edgesIgnoringSafeArea(.all)
                RegisterView()
            } else if login.estado == .valoraciones{
                ValoracionesView(listaFiles: listaFiles)
            } else {
                LoadView()
            }
        }.onAppear {
            files.getFilesAValorar{ termina in
                if termina {
                    if (UserDefaults.standard.object(forKey: "logueado")) != nil {
                        if files.filesValorar.count > 0 {
                            login.estado = .valoraciones
                            listaFiles = files.filesValorar
                        } else {
                            login.estado = .logueado
                        }
                    } else {
                        login.estado = .login
                    }
                }
            }
        }
    }
}
