//
//  ImagenStorageView.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 5/5/21.
//

import SwiftUI

struct ImagenStorageView: View {
    @StateObject var imageLoader: DocumentViewModel = DocumentViewModel(documentURL: "")
    let imageURL: String
    let anchura: CGFloat
    let tipo: String
    
    var body: some View {
        if imageURL != "" {
            VStack(alignment: .leading){
                Image(uiImage: imageLoader.data.flatMap(UIImage.init) ?? UIImage(named: tipo)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: anchura)
                    .onAppear{
                        imageLoader.documentURL = imageURL
                        imageLoader.load()
                    }
            }
        } else {
            VStack(alignment: .leading){
                Image(uiImage: UIImage(named: tipo)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: anchura)
            }
        }
    }
}
