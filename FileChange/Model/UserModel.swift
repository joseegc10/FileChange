//
//  PersonModel.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 4/5/21.
//

import Foundation

struct UserModel: Identifiable {
    var id: String = ""
    var nombre: String = ""
    var apellidos: String = ""
    var correo: String = ""
    var valoracionesPendientes: [String] = []
    var descargas: [String] = []
    var descargasTipo = [String:Int]()
}
