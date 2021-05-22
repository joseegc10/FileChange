//
//  FileModel.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 4/5/21.
//

import Foundation

/// Tipo de archivo posible
enum TipoFile: String, CaseIterable {
    case libro = "Libro"
    case comic = "Comic"
    case poema = "Poema"
    case revista = "Revista"
    case apuntes = "Apuntes"
    case otro = "Otro"
}

/// Objeto que contiene los atributos de un archivo común
struct FileModel: Identifiable, Hashable {    
    var id: String = ""                         /// Id del archivo
    var titulo: String = ""                     /// Título del archivo
    var descripcion: String = ""                /// Descripción del archivo
    var portada: Data = .init(capacity: 0)      /// Portada del archivo
    var dirPortada: String = ""                 /// Dirección de la portada en Storage
    var archivo: Data = .init(capacity: 0)      /// Archivo
    var dirArchivo: String = ""                 /// Dirección del archivo en Storage
    var valoracionMedia: Double = -1               /// Valoración media del archivo
    var numValoraciones: Int = 0                /// Número de valoraciones que tiene el archivo
    var idCreador: String = ""                  /// Id del usuario que ha creado el archivo
    var tipoArchivo: String = "Libro"           /// Tipo del archivo
    var nombreAutor: String = ""                /// Nombre del autor
}
