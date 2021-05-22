//
//  RegisterView.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 4/5/21.
//

import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var nombre = ""
    @State private var apellidos = ""
    
    @StateObject var login = FirebaseAuth()
    @EnvironmentObject var estado: FirebaseAuth
    
    @StateObject var usuarios = FileViewModel()
    
    var body: some View {
        VStack(spacing: 20){
            Text("FileChange")
                .font(.largeTitle)
                .foregroundColor(.white)
                .bold()
            
            TextField("Nombre", text: $nombre)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            TextField("Apellidos", text: $apellidos)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 20)
            
            Button(action:{
                login.register(email: email, password: password) { (done) in
                    if done{
                        let user = UserModel(nombre: nombre, apellidos: apellidos, correo: email)
                        usuarios.addUserInfo(user: user)
                        UserDefaults.standard.set(true, forKey: "logueado")
                        estado.estado = .logueado
                    }
                }
            }){
                Text("Registrar")
                    .font(.title)
                    .frame(width: 200 )
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
            }.background(
                Capsule()
                    .stroke(Color.white)
            )
            
            Button(action:{
                estado.estado = .login
            }){
                Text("Volver a login")
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }.padding(.all)
    }
}
