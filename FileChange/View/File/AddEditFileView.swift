//
//  AddEditFileView.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 5/5/21.
//

import SwiftUI
import MapKit
import Firebase

struct AddEditFileView: View {
    @State var file = FileModel()
    let tiposPosibles: [String] = TipoFile.allCases.map{ $0.rawValue }
    @State private var tipoElegido: [String:Bool] = [:]
    
    @StateObject var files = FileViewModel()

    var editar: Bool = false
    
    @State private var elegirCapacidad = false
    
    @State private var alerta = false
    @State private var mensajeFin = false
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    
    @State private var imageData : Data = .init(capacity: 0)
    @State private var mostrarMenu = false
    @State private var imagePicker = false
    @State private var source : UIImagePickerController.SourceType = .camera
    
    @State private var fileName = ""
    @State private var elegirFile = false
    
    @State private var elegido = false
    
    @State private var borrado = false
    
    var body: some View {
        NavigationView{
            ZStack {
                Color("navBar").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                ScrollView{
                    // Formulario
                    VStack(spacing: 10){
                        VStack{
                            Spacer()
                            
                            ZStack {
                                HStack {
                                    if alerta {
                                        Spacer()
                                        ProgressView()
                                            .padding(.bottom, 30)
                                            .padding(.trailing, 30)
                                    }
                                }
                                
                                
                                Button(action:{
                                    mostrarMenu.toggle()
                                }){
                                    if imageData.count != 0 {
                                        Image(uiImage: UIImage(data: imageData)!)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 150)
                                    } else {
                                        ImagenStorageView(imageURL: file.dirPortada, anchura: 120, tipo: file.tipoArchivo)
                                    }
                                }.actionSheet(isPresented: $mostrarMenu, content: {
                                    ActionSheet(title: Text("Menu"), message: Text("Selecciona una opción"), buttons: [
                                        .default(Text("Cámara"), action: {
                                            source = .camera
                                            imagePicker.toggle()
                                        }),
                                        .default(Text("Librería"), action: {
                                            source = .photoLibrary
                                            imagePicker.toggle()
                                        }),
                                        .default(Text("Cancelar"))
                                    ])
                                }).sheet(isPresented: $imagePicker) {
                                    ImagePicker(show: $imagePicker, image: $imageData, source: source)
                                }
                            }
                        }
                        
                        VStack(alignment:.leading, spacing: 10){
                            Text("Titulo")
                                .bold()
                                .font(.body)
                                .foregroundColor(.white)
                            
                            TextField("", text: $file.titulo)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color("navBar"), lineWidth: 2)
                                )
                            
                            Spacer()
                            
                            Text("Descripción")
                                .bold()
                                .font(.body)
                                .foregroundColor(.white)
                            
                            TextEditor(text: $file.descripcion)
                                .frame(height:100, alignment: .center)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color("navBar"), lineWidth: 2)
                                )
                                .lineSpacing(10)
                                .disableAutocorrection(true)
                            
                            Spacer()
                            
                            Text("Nombre del autor")
                                .bold()
                                .font(.body)
                                .foregroundColor(.white)
                            
                            TextField("", text: $file.nombreAutor)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color("navBar"), lineWidth: 2)
                                )
                            
                            Spacer()
                        }.padding(.horizontal)
                        
                        TiposPickerView(selectedTitle: $file.tipoArchivo, tipoInicial: file.tipoArchivo)
                        
                        Spacer()
                        
                        VStack(spacing: 15){
                            Button(action:{
                                elegirFile.toggle()
                                elegido = true
                            }){
                                HStack(alignment: .center, spacing: 15){
                                    Image(systemName: "doc")
                                        .font(.system(size: 25))
                                        .foregroundColor(.black)
                                    
                                    Text("Elegir archivo")
                                        .bold()
                                        .font(.body)
                                        .foregroundColor(.black)
                                }.frame(width: UIScreen.main.bounds.width - 60)
                            }.fileImporter(isPresented: $elegirFile, allowedContentTypes: [.pdf]) { res in
                                do {
                                    let fileURL = try res.get()
                                    
                                    if self.file.dirArchivo != "" {
                                        let storageFile = Storage.storage().reference(forURL: self.file.dirArchivo)
                                        storageFile.delete(completion: nil)
                                    }
                                                
                                    let storage = Storage.storage().reference()
                                    let nombreArchivo = UUID()
                                    let directorioArchivo = storage.child("archivos/\(nombreArchivo)")
                                    self.file.dirArchivo = String(describing: directorioArchivo)
                                    let metadata = StorageMetadata()
                                    metadata.contentType = "application/pdf"
                                
                                    if fileURL.startAccessingSecurityScopedResource() {
                                        let data = try Data(contentsOf: fileURL)
                                        
                                        directorioArchivo.putData(data, metadata: metadata) { (_, err) in
                                            if err != nil {
                                                print("error al subir archivo: " + (err?.localizedDescription)!)
                                                return
                                            }
                                            
                                            print(file.dirArchivo)
                                            print("Archivo subido correctamente")
                                        }
                                    } else {
                                        print("Sin permiso")
                                    }
                                    
                                } catch {
                                    print("error al importar archivo: ", error.localizedDescription)
                                }
                            }
                        }.padding()
                        .background(Color(.white))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color("navBar"), lineWidth: 2)
                        )
                        
                        Spacer()
                    }
                }.onTapGesture {
                    self.hideKeyboard()
                }
                .onDisappear{
                    let bucket = Storage.storage().reference()
                    
                    if self.file.dirArchivo != "" && !editar{
                        bucket.child(self.file.dirArchivo).delete { (error) in
                            if error != nil {
                                print("error al eliminar archivo")
                                print((error?.localizedDescription)!)
                            } else {
                                print("eliminado correctamente")
                            }
                        }
                    }
                }
                .onAppear{
                    if file.id != "" {
                        elegido = true
                    }
                }
                
                VStack {
                    HStack {
                        if editar {
                            Button(action: {
                                alerta = true
                                files.deleteFile(file: file){ (fin) in
                                    if fin {
                                        alerta = false
                                        borrado = true
                                    }
                                }
                            }, label: {
                                Image(systemName: "trash")
                                    .font(.system(size: 25))
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color("navBar"))
                            })
                            .background(Color.white)
                            .cornerRadius(30)
                            .padding()
                            .shadow(color: Color.black.opacity(0.3),
                                    radius: 3,
                                    x: 3,
                                    y: 3)
                        }
                        Spacer()
                        Button(action: {
                            alerta = true
                            
                            if !editar {
                                file.id = UUID().uuidString
                                guard let idUser = Auth.auth().currentUser?.uid else { return }
                                file.idCreador = idUser
                                file.portada = imageData
                                files.addFile(file: file){ (fin) in
                                    if fin {
                                        alerta = false
                                        file = FileModel()
                                        imageData = .init(capacity: 0)
                                        mensajeFin = true
                                    }
                                }
                            } else {
                                if imageData.count != 0 {
                                    file.portada = imageData
                                    files.editFileWithImage(file: file) { (fin) in
                                        if fin {
                                            alerta = false
                                            imageData = .init(capacity: 0)
                                            mensajeFin = true
                                        }
                                    }
                                } else {
                                    files.editFile(file: file) { (fin) in
                                        if fin {
                                            alerta = false
                                            imageData = .init(capacity: 0)
                                            mensajeFin = true
                                        }
                                    }
                                }
                            }
                        }, label: {
                            if editar {
                                Image(systemName: "pencil")
                                    .font(.system(size: 30))
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color("navBar"))
                            } else {
                                Image(systemName: "plus")
                                    .font(.system(size: 25))
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color("navBar"))
                            }
                        })
                        .background(Color.white)
                        .cornerRadius(30)
                        .padding()
                        .shadow(color: Color.black.opacity(0.3),
                                radius: 3,
                                x: 3,
                                y: 3)
                        .disabled(file.titulo == "" || file.tipoArchivo == "" || file.descripcion == "" || file.nombreAutor == "" || !elegido)
                    }
                    
                    Spacer()
                }.alert(isPresented: $mensajeFin) {
                    if editar {
                        return Alert(title: Text("Archivo editado correctamente"), message: Text(""), dismissButton: .default(Text("Ok")))
                    } else {
                        return Alert(title: Text("Archivo creado correctamente"), message: Text(""), dismissButton: .default(Text("OK")))
                    }
                    
                }
            }.navigationBarTitle("Añadir", displayMode: .inline)
            .navigationBarHidden(editar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Añadir").font(.headline).foregroundColor(Color.white)
                    }
                }
            }
            .alert(isPresented: $borrado) {
                Alert(title: Text("Archivo eliminado correctamente"), message: Text(""), dismissButton: .default(Text("Ok")))
            }
        }
    }
}

