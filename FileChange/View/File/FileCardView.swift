//
//  FileCardView.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 5/5/21.
//

import SwiftUI
import Firebase

struct FileCardView: View {
    var file: FileModel
    @State private var estoyEdit = false
    @State private var estoyViendo = false
    
    var body: some View {
        VStack (alignment: .leading){
            ImagenStorageView(imageURL: file.dirPortada, anchura: 130, tipo: file.tipoArchivo)
            
            Text(file.titulo)
                .font(.headline)
                .bold()
                .foregroundColor(.white)
            
            Text(file.nombreAutor)
                .font(.subheadline)
                .foregroundColor(.white)
            
            Spacer()
            
            HStack {
                ForEach(1..<6, id: \.self, content: { i in
                    if Int(file.valoracionMedia) < i {
                        Image(systemName: "star")
                            .font(.subheadline)
                    } else {
                        Image(systemName: "star.fill")
                            .font(.subheadline)
                    }
                })
            }.foregroundColor(Color("gold"))
            
            NavigationLink("", destination: AddEditFileView(file: file, editar: true), isActive: $estoyEdit)
            
            NavigationLink("", destination: FileView(file: file), isActive: $estoyViendo)
        }.padding(.leading)
        .onTapGesture {
            guard let idUser = Auth.auth().currentUser?.uid else { return }

            if idUser == file.idCreador {
                estoyEdit.toggle()
            } else {
                estoyViendo.toggle()
            }
        }
    }
}
