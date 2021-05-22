//
//  DocumentViewModel.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 5/5/21.
//

import Foundation
import Firebase

/// Clase para obtener la imagen desde Storage de Firebase
class DocumentViewModel: ObservableObject {
    @Published var data : Data? = nil   /// Datos
    @Published var documentURL : String    /// URL del documento
    
    /// Almacenamos la dirección del documento
    init(documentURL: String) {
        self.documentURL = documentURL
    }
    
    /// Obtenemos el documento
    func load(){
        print(self.documentURL)
        let storageImage = Storage.storage().reference(forURL: documentURL)
        storageImage.getData(maxSize: 1024 * 1024 * 1024) { (data, error) in
            if let error = error?.localizedDescription {
                print("error al obtener el documento", error)
            }else{
                print("documento obtenido correctamente")
                self.data = data
            }
        }
    }
}

