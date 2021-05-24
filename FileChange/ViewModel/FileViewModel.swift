//
//  FileViewModel.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 4/5/21.
//

import Foundation
import Firebase

/// Clase para el manejo de los archivos
class FileViewModel: ObservableObject {
    @Published var files = [FileModel]()
    @Published var misArchivos = [FileModel]()
    @Published var misDescargas = [FileModel]()
    @Published var filesValorar = [FileModel]()
    @Published var filesRecomendados = [FileModel]()
    @Published var user = UserModel()
    @Published var file: Data = .init(capacity: 0)
    @Published var filesTipo = [String:[FileModel]]()
    let tiposPosibles: [String] = TipoFile.allCases.map{ $0.rawValue }
    
    init() {
        for tipo in tiposPosibles {
            filesTipo[tipo] = []
        }
    }
    
    /// Añadir un archivo a firebase
    /// - Parameter archivo: Archivo a subir
    func addFile(file: FileModel, completion: @escaping (Bool) -> Void){
        let storage = Storage.storage().reference()
        let nombrePortada = UUID()
        let directorioImagen = storage.child("imagenes/\(nombrePortada)")
        let metadataPortada = StorageMetadata()
        metadataPortada.contentType = "image/png"
        
        directorioImagen.putData(file.portada, metadata: metadataPortada){data, error in
            if error == nil {
                print("guardo la imagen")
                
                let db = Firestore.firestore()
                let id = UUID().uuidString
                guard let idUser = Auth.auth().currentUser?.uid else { return }

                let campos: [String:Any] = ["titulo": file.titulo, "descripcion":file.descripcion, "dirPortada":String(describing: directorioImagen), "dirArchivo":file.dirArchivo, "valoracionMedia":-1, "numValoraciones":0, "idCreador":idUser, "tipoArchivo":file.tipoArchivo, "nombreAutor":file.nombreAutor]
                db.collection("archivos").document(id).setData(campos){error in
                    if let e = error?.localizedDescription {
                        print("Error al guardar información del usuario", e)
                    } else {
                        print("Guardado correctamente")
                        completion(true)
                    }
                }
            } else {
                if let error = error?.localizedDescription {
                    print("error al subir la imagen en storage", error)
                } else {
                    print("error en la app al subir imagen")
                }
            }
        }
    }
    
    /// Añadir la información del usuario a firebase
    /// - Parameter user: Usuario a añadir
    func addUserInfo(user: UserModel){
        let db = Firestore.firestore()
        guard let id = Auth.auth().currentUser?.uid else { return }

        let campos: [String:Any] = ["nombre": user.nombre, "apellidos":user.apellidos, "correo":user.correo, "valoracionesPendientes":user.valoracionesPendientes, "descargas":user.descargas]
        db.collection("usuarios").document(id).setData(campos){error in
            if let e = error?.localizedDescription {
                print("Error al guardar información del usuario", e)
            } else {
                print("Guardado correctamente")
            }
        }
    }
    
    func docEnUser(valor: [String:Any], id: String) -> UserModel{
        let nombre = valor["nombre"] as? String ?? ""
        let apellidos = valor["apellidos"] as? String ?? ""
        let correo = valor["correo"] as? String ?? ""
        let valoracionesPendientes = valor["valoracionesPendientes"] as? [String] ?? []
        let descargas = valor["descargas"] as? [String] ?? []
        let descargasTipo = valor["descargasTipo"] as? [String:Int] ?? [:]
        
        let user = UserModel(id: id, nombre: nombre, apellidos: apellidos,
                             correo: correo, valoracionesPendientes: valoracionesPendientes, descargas: descargas, descargasTipo: descargasTipo)
        
        return user
    }
    
    func getUserInfo() {
        let db = Firestore.firestore()
        guard let id = Auth.auth().currentUser?.uid else { return }
        
        db.collection("usuarios").document(id).getDocument { (doc, error) in
            if let doc = doc, doc.exists {
                let datos = doc.data()
                self.user = self.docEnUser(valor: datos!, id: doc.documentID)
            } else {
                print("Error al obtener información del usuario")
            }
        }
    }
    
    func docEnFile(document: QueryDocumentSnapshot) -> FileModel{
        let valor = document.data()
        let titulo = valor["titulo"] as? String ?? ""
        let descripcion = valor["descripcion"] as? String ?? ""
        let dirPortada = valor["dirPortada"] as? String ?? ""
        let dirArchivo = valor["dirArchivo"] as? String ?? ""
        let valoracionMedia = valor["valoracionMedia"] as? Double ?? -1
        let numValoraciones = valor["numValoraciones"] as? Int ?? 0
        let idCreador = valor["idCreador"] as? String ?? ""
        let tipoArchivo = valor["tipoArchivo"] as? String ?? ""
        let nombreAutor = valor["nombreAutor"] as? String ?? ""

        let file = FileModel(id: document.documentID, titulo: titulo, descripcion: descripcion, dirPortada: dirPortada, dirArchivo: dirArchivo, valoracionMedia: valoracionMedia, numValoraciones: numValoraciones, idCreador: idCreador, tipoArchivo: tipoArchivo, nombreAutor: nombreAutor)
        
        return file
    }
    
    func docEnFile(valor: [String:Any], id: String) -> FileModel{
        let titulo = valor["titulo"] as? String ?? ""
        let descripcion = valor["descripcion"] as? String ?? ""
        let dirPortada = valor["dirPortada"] as? String ?? ""
        let dirArchivo = valor["dirArchivo"] as? String ?? ""
        let valoracionMedia = valor["valoracionMedia"] as? Double ?? -1
        let numValoraciones = valor["numValoraciones"] as? Int ?? 0
        let idCreador = valor["idCreador"] as? String ?? ""
        let tipoArchivo = valor["tipoArchivo"] as? String ?? ""
        let nombreAutor = valor["nombreAutor"] as? String ?? ""

        let file = FileModel(id: id, titulo: titulo, descripcion: descripcion, dirPortada: dirPortada, dirArchivo: dirArchivo, valoracionMedia: valoracionMedia, numValoraciones: numValoraciones, idCreador: idCreador, tipoArchivo: tipoArchivo, nombreAutor: nombreAutor)
        
        return file
    }
    
    func getUserFiles(cadena: String? = nil) {
        let db = Firestore.firestore()
        guard let idUser = Auth.auth().currentUser?.uid else { return }
        
        db.collection("archivos").whereField("idCreador", isEqualTo: idUser)
            .getDocuments(){ (querySnapshot, err) in
                if let err = err {
                    print("Error al obtener archivos del usuario: \(err)")
                } else {
                    self.misArchivos.removeAll()
                    for document in querySnapshot!.documents {
                        let nuevoFile = self.docEnFile(document: document)
                        
                        if cadena != nil {
                            if nuevoFile.titulo.lowercased().contains(cadena!.lowercased()){
                                self.misArchivos.append(nuevoFile)
                            }
                        } else {
                            self.misArchivos.append(nuevoFile)
                        }
                    }
                }
        }
    }
    
    func getUserDownloads(cadena: String? = nil) {
        let db = Firestore.firestore()
        guard let id = Auth.auth().currentUser?.uid else { return }
        
        db.collection("usuarios").document(id).getDocument { (doc, error) in
            if let doc = doc, doc.exists {
                let datos = doc.data()
                self.user = self.docEnUser(valor: datos!, id: doc.documentID)
                self.misDescargas.removeAll()
                
                for descarga in self.user.descargas {
                    let docBar = db.collection("archivos").document(descarga)

                    docBar.getDocument { [self] (document2, error2) in
                        if let document2 = document2, document2.exists {
                            let datos = document2.data()
                            let nuevoFile = docEnFile(valor: datos!, id: document2.documentID)
                            
                            if cadena != nil {
                                if nuevoFile.titulo.lowercased().contains(cadena!.lowercased()){
                                    self.misDescargas.append(nuevoFile)
                                }
                            } else {
                                self.misDescargas.append(nuevoFile)
                            }
                        } else {
                            print("Error al obtener descargas del usuario")
                        }
                    }
                }
            } else {
                print("Error al obtener descargas del usuario")
            }
        }
    }
    
    func editFile(file: FileModel, completion: @escaping (Bool) -> Void){
        let db = Firestore.firestore()
        let campos: [String:Any] = ["titulo": file.titulo, "descripcion":file.descripcion, "tipoArchivo":file.tipoArchivo, "dirArchivo":file.dirArchivo, "nombreAutor":file.nombreAutor]
        db.collection("archivos").document(file.id).updateData(campos){ (error) in
            if let error = error?.localizedDescription {
                print("Error al editar archivo", error)
            } else {
                print("Edito correctamente el archivo")
                completion(true)
            }
        }
    }
    
    func editFileWithImage(file: FileModel, completion: @escaping (Bool) -> Void){
        let storageImage = Storage.storage().reference(forURL: file.dirPortada)
        storageImage.delete(completion: nil)
        
        let storage = Storage.storage().reference()
        let nombrePortada = UUID()
        let directorioImagen = storage.child("imagenes/\(nombrePortada)")
        let metadataPortada = StorageMetadata()
        metadataPortada.contentType = "image/png"
        
        directorioImagen.putData(file.portada, metadata: metadataPortada){data, error in
            if error == nil {
                print("guardo la imagen")
                // Guardamos primero la imagen y ahora el texto ya que la imagen tarda mas
                let db = Firestore.firestore()
                let campos: [String:Any] = ["titulo": file.titulo, "descripcion":file.descripcion, "tipoArchivo":file.tipoArchivo, "dirPortada":String(describing: directorioImagen), "dirArchivo":file.dirArchivo, "nombreAutor":file.nombreAutor]
                db.collection("archivos").document(file.id).updateData(campos){ (error) in
                    if let error = error?.localizedDescription {
                        print("Error al editar archivo", error)
                    } else {
                        print("Edito correctamente el archivo")
                        completion(true)
                    }
                }
            } else {
                if let error = error?.localizedDescription {
                    print("error al subir la imagen en storage", error)
                } else {
                    print("error en la app al subir imagen")
                }
            }
        }
    }
    
    func deleteFile(file: FileModel, completion: @escaping (Bool) -> Void){
        let db = Firestore.firestore()
        db.collection("archivos").document(file.id).delete()
            
        let storageImage = Storage.storage().reference(forURL: file.dirPortada)
        storageImage.delete(completion: nil)
        
        let storageFile = Storage.storage().reference(forURL: file.dirArchivo)
        storageFile.delete(completion: nil)
        
        completion(true)
    }
    
    func getFile(url: String){        
        let storageImage = Storage.storage().reference(forURL: url)
        storageImage.getData(maxSize: 1024 * 1024 * 1024) { (data, error) in
            if let error = error?.localizedDescription {
                print("error al obtener el documento", error)
            }else{
                print("documento obtenido correctamente")
                print(data!.count)
                self.file = data!
            }
        }
    }
    
    func busquedaFiles(nombreBuscado: String, tipoBuscado: String){
        let db = Firestore.firestore()
        db.collection("archivos").whereField("tipoArchivo", isEqualTo: tipoBuscado)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error al obtener archivos por tipo: \(err)")
                } else {
                    self.files.removeAll()
                    for document in querySnapshot!.documents {
                        let nuevoFile = self.docEnFile(document: document)
                        
                        if nuevoFile.titulo.lowercased().contains(nombreBuscado.lowercased()){
                            self.files.append(nuevoFile)
                        }
                    }
                }
        }
    }
    
    func busquedaFilesTipo(tipoBuscado: String, completion: @escaping (Bool) -> Void){
        let db = Firestore.firestore()
        db.collection("archivos").whereField("tipoArchivo", isEqualTo: tipoBuscado)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error al obtener archivos por tipo: \(err)")
                } else {
                    self.filesTipo[tipoBuscado]!.removeAll()
                    for document in querySnapshot!.documents {
                        let nuevoFile = self.docEnFile(document: document)
                        
                        self.filesTipo[tipoBuscado]!.append(nuevoFile)
                    }
                    
                    completion(true)
                }
        }
    }
    
    func aniadeDescarga(idFile: String, tipo: String){
        let db = Firestore.firestore()
        guard let id = Auth.auth().currentUser?.uid else { return }
        
        db.collection("usuarios").document(id).getDocument { (doc, error) in
            if let doc = doc, doc.exists {
                let datos = doc.data()
                self.user = self.docEnUser(valor: datos!, id: doc.documentID)
                
                var miUser = self.user
                
                if !miUser.descargas.contains(idFile){
                    miUser.descargas.append(idFile)
                    miUser.valoracionesPendientes.append(idFile)
                    
                    if miUser.descargasTipo[tipo] != nil {
                        miUser.descargasTipo[tipo]! += 1
                    } else {
                        miUser.descargasTipo[tipo] = 1
                    }
                    
                    let campos: [String:Any] = ["descargas": miUser.descargas, "valoracionesPendientes": miUser.valoracionesPendientes, "descargasTipo": miUser.descargasTipo]
                    db.collection("usuarios").document(miUser.id).updateData(campos){ (error) in
                        if let error = error?.localizedDescription {
                            print("Error al añadir descarga", error)
                        } else {
                            print("Descarga añadida correctamente")
                        }
                    }
                }
            } else {
                print("Error al obtener información del usuario")
            }
        }
        
        
    }
    
    func getFilesAValorar(completion: @escaping (Bool) -> Void){
        let db = Firestore.firestore()
        let id = Auth.auth().currentUser?.uid ?? ""
        
        if id != "" {
            db.collection("usuarios").document(id).getDocument { (doc, error) in
                
                if let doc = doc, doc.exists {
                    
                    let datos = doc.data()
                    self.user = self.docEnUser(valor: datos!, id: doc.documentID)
                    
                    db.collection("archivos").getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error al obtener archivos a valorar: \(err)")
                        } else {
                            self.filesValorar.removeAll()
                            for document in querySnapshot!.documents {
                                let nuevoFile = self.docEnFile(document: document)
                                
                                if self.user.valoracionesPendientes.contains(nuevoFile.id){
                                    self.filesValorar.append(nuevoFile)
                                }
                            }
                            
                            completion(true)
                        }
                    }
                } else {
                    print("Error al obtener información del usuario")
                }
            }
        } else {
            completion(true)
        }
    }
    
    func deleteFileValorar(idFile: String){
        let db = Firestore.firestore()
        guard let id = Auth.auth().currentUser?.uid else { return }
        
        db.collection("usuarios").document(id).getDocument { (doc, error) in
            if let doc = doc, doc.exists {
                let datos = doc.data()
                self.user = self.docEnUser(valor: datos!, id: doc.documentID)
                
                var miUser = self.user
                
                if miUser.valoracionesPendientes.contains(idFile){
                    miUser.valoracionesPendientes.remove(at: miUser.valoracionesPendientes.firstIndex(of: idFile)!)
                    
                    let db = Firestore.firestore()
                    let campos: [String:Any] = ["valoracionesPendientes": miUser.valoracionesPendientes]
                    db.collection("usuarios").document(miUser.id).updateData(campos){ (error) in
                        if let error = error?.localizedDescription {
                            print("Error al eliminar archivo a valorar", error)
                        } else {
                            print("Archivo a valorar eliminado correctamente")
                        }
                    }
                }
            } else {
                print("Error al obtener información del usuario")
            }
        }
    }
    
    func aniadeValoracion(idFile: String, valoracion: Int){
        let db = Firestore.firestore()

        db.collection("archivos").document(idFile).getDocument { (doc, error) in
            if let doc = doc, doc.exists {
                let datos = doc.data()
                var miFile = self.docEnFile(valor: datos!, id: doc.documentID)
                
                let sumaValoraciones = miFile.valoracionMedia * Double(miFile.numValoraciones)
                miFile.valoracionMedia = ((sumaValoraciones) + Double(valoracion)) / (Double(miFile.numValoraciones+1))
                miFile.numValoraciones += 1
                
                let campos: [String:Any] = ["valoracionMedia": miFile.valoracionMedia, "numValoraciones": miFile.numValoraciones]
                db.collection("archivos").document(miFile.id).updateData(campos){ (error) in
                    if let error = error?.localizedDescription {
                        print("Error al añadir valoracion", error)
                    } else {
                        print("Valoracion añadida correctamente")
                    }
                }
            } else {
                print("Error al obtener archivo")
            }
        }
    }
    
    func actualizaFilesTipo(tipo: String){
        files.removeAll()
        files = filesTipo[tipo]!
    }
    
    func getFilesRecomendados(cadena: String? = nil){
        let db = Firestore.firestore()
        guard let id = Auth.auth().currentUser?.uid else { return }
        
        db.collection("usuarios").document(id).getDocument { (doc, error) in
            if let doc = doc, doc.exists {
                let datos = doc.data()
                self.user = self.docEnUser(valor: datos!, id: doc.documentID)
                
                let miUser: UserModel = self.user
                
                db.collection("archivos").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error al obtener archivos a valorar: \(err)")
                    } else {
                        self.filesRecomendados.removeAll()
                        for document in querySnapshot!.documents {
                            let nuevoFile = self.docEnFile(document: document)
                            
                            self.filesRecomendados.append(nuevoFile)
                        }
                        
                        var nuevoFiles = [FileModel]()
                        var i = 0
                        
                        while (i < self.filesRecomendados.count){
                            let miFile: FileModel = self.filesRecomendados[i]

                            var j = 0
                            
                            let valorTipoFile: Int = miUser.descargasTipo[miFile.tipoArchivo] ?? 0
                            var termina = false
                            
                            while (j < nuevoFiles.count && !termina){
                                if ((nuevoFiles[j].valoracionMedia > miFile.valoracionMedia) || ((nuevoFiles[j].valoracionMedia == miFile.valoracionMedia) && ((miUser.descargasTipo[nuevoFiles[j].tipoArchivo] ?? 0) < valorTipoFile))){
                                    j += 1
                                } else {
                                    termina = true
                                }
                            }


                            if cadena != nil {
                                if miFile.titulo.lowercased().contains(cadena!.lowercased()){
                                    nuevoFiles.insert(miFile, at: j)
                                }
                            } else {
                                nuevoFiles.insert(miFile, at: j)
                            }
                            
                            i += 1
                        }

                        self.filesRecomendados = nuevoFiles
                    }
                }
            } else {
                print("Error al obtener información del usuario")
            }
        }
    }
}
