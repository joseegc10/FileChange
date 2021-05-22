//
//  FirebaseAuth.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 4/5/21.
//

import Foundation
import Combine
import Firebase

enum TipoInicio {
    case login
    case register
    case logueado
    case valoraciones
    case inicio
}

class FirebaseAuth: ObservableObject {
    @Published var estado: TipoInicio = .inicio
    
    /// Login en firebase
    /// - Parameters:
    ///   - email: email del usuario
    ///   - password: contraseña del usuario
    ///   - completion: Para saber si se ha hecho correctamente
    func login(email: String, password: String, completion: @escaping (_ done: Bool) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if user != nil {
                print("Ha entrado")
                completion(true)
            } else {
                if let error = error?.localizedDescription {
                    print("Error login en firebase: ", error)
                } else {
                    print("Error en la app")
                }
            }
        }
    }
    
    
    /// Registro en la app
    /// - Parameters:
    ///   - email: email del usuario
    ///   - password: contraseña del usuario
    ///   - completion: Para saber si se ha hecho correctamente
    func register(email: String, password: String, completion: @escaping (_ done: Bool) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if user != nil {
                print("Se ha registrado")
                completion(true)
            } else {
                if let error = error?.localizedDescription {
                    print("Error registro en firebase: ", error)
                } else {
                    print("Error en la app")
                }
            }
        }
    }
}
