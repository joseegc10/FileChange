//
//  LoginView.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 4/5/21.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    @StateObject var login = FirebaseAuth()
    @EnvironmentObject var estado: FirebaseAuth
    
    var body: some View {
        VStack{
            Text("FileChange")
                .font(.largeTitle)
                .foregroundColor(.white)
                .bold()
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 20)
            
            Button(action:{
                login.login(email: email, password: password) { (done) in
                    if done{
                        UserDefaults.standard.set(true, forKey: "logueado")
                        estado.estado = .logueado
                    }
                }
            }){
                Text("Entrar")
                    .font(.title)
                    .frame(width: 200 )
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
            }.background(
                Capsule()
                    .stroke(Color.white)
            )
            
            Button(action:{
                estado.estado = .register
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
            
            
            
        }.padding(.all)
    }
}
