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
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    
    @State private var imageData : Data = .init(capacity: 0)
    @State private var mostrarMenu = false
    @State private var imagePicker = false
    @State private var source : UIImagePickerController.SourceType = .camera
    
    @State private var fileName = ""
    @State private var elegirFile = false
    
    @State private var elegido = false
    
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
                            }.sheet(isPresented: $elegirFile) {
                                FilePicker(file: $file)
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
                                    }
                                }
                            } else {
                                if imageData.count != 0 {
                                    file.portada = imageData
                                    files.editFileWithImage(file: file) { (fin) in
                                        if fin {
                                            alerta = false
                                            imageData = .init(capacity: 0)
                                        }
                                    }
                                } else {
                                    files.editFile(file: file) { (fin) in
                                        if fin {
                                            alerta = false
                                            imageData = .init(capacity: 0)
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
        }
    }
}

