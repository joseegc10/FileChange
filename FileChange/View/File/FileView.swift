//
//  FileView.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 10/5/21.
//

import SwiftUI
import UniformTypeIdentifiers

struct FileView: View {
    @State var file = FileModel()
    @State private var saveFile = false
    @StateObject var files = FileViewModel()
    @State private var ext = ""
    
    var body: some View {
        ZStack {
            Color("navBar").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ScrollView {
                VStack(spacing: 20) {
                    Spacer()
                    
                    ImagenStorageView(imageURL: file.dirPortada, anchura: 120, tipo: file.tipoArchivo)
                    
                    VStack(spacing: 15){
                        Text(file.titulo)
                            .bold()
                            .font(.title)
                            .foregroundColor(.white)
                        
                        Text("Por " + file.nombreAutor)
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        HStack {
                            ForEach(0..<5, id: \.self, content: { i in
                                if Int(file.valoracionMedia) < i {
                                    Image(systemName: "star")
                                } else {
                                    Image(systemName: "star.fill")
                                }
                            })
                            
                            Text("(\(file.numValoraciones))")
                        }.foregroundColor(Color("gold"))
                        
                        Text(file.tipoArchivo)
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Text(file.descripcion)
                        .padding(.horizontal, 30)
                        .foregroundColor(.white)
                    
                    Spacer()
                }.onAppear{
                    files.getFile(url: file.dirArchivo)
                }
            }
            
            VStack{
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action:{
                        saveFile.toggle()
                    }){
                        HStack {
                            Image(systemName: "square.and.arrow.down.fill")
                                .font(.system(size: 26))
                                .foregroundColor(Color("navBar"))
                        }
                    }.padding()
                    .background(Color.white)
                    .cornerRadius(40)
                    .padding(.trailing)
                    .padding(.bottom)
                    .fileExporter(isPresented: $saveFile, document: Doc(data: files.file), contentType: .pdf) { (res) in
                        do {
                            let fileUrl = try res.get()
                            print(fileUrl)
                            files.aniadeDescarga(idFile: file.id, tipo: file.tipoArchivo)
                        } catch {
                            print("error al guardar archivo")
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
        
    }
}

struct Doc: FileDocument {
    static var readableContentTypes: [UTType]{[.pdf]}
    var data: Data = .init(capacity: 0)
    
    init(data: Data){
        self.data = data
    }
    
    init(configuration: ReadConfiguration) throws {
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let file = FileWrapper(regularFileWithContents: data)
        
        return file
    }
    
}
