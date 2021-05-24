//
//  FilePicker.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 9/5/21.
//

import Foundation
import SwiftUI
import MobileCoreServices
import Firebase

struct FilePicker: UIViewControllerRepresentable {
    func makeCoordinator() -> FilePicker.Coordinator {
        return FilePicker.Coordinator(parent1: self)
    }
    
    @Binding var file: FileModel
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<FilePicker>) -> UIDocumentPickerViewController {
        
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<FilePicker>) {
        
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: FilePicker
        
        init(parent1: FilePicker) {
            parent = parent1
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            let fileURL = urls.first!
            
            if self.parent.file.dirArchivo != "" {
                let storageFile = Storage.storage().reference(forURL: self.parent.file.dirArchivo)
                storageFile.delete(completion: nil)
            }
                        
            let storage = Storage.storage().reference()
            let nombreArchivo = UUID()
            let directorioArchivo = storage.child("archivos/\(nombreArchivo)")
            self.parent.file.dirArchivo = String(describing: directorioArchivo)
            
            directorioArchivo.putFile(from: fileURL, metadata: nil) { (_, err) in
                if err != nil {
                    print("error al subir archivo: " + (err?.localizedDescription)!)
                    return
                }
                
                print("Archivo subido correctamente")
            }
        }
    }
}
