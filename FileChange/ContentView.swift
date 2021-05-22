//
//  ContentView.swift
//  FileChange
// by Jose Alberto Garcia Collado on 3/5/21.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView: View {
    @Environment(\.presentationMode) var presentation
    let tiposPosibles: [String] = TipoFile.allCases.map{ $0.rawValue }
    @StateObject var files = FileViewModel()
    @State var libro = false
    @State var comic = false
    @State var poema = false
    @State var revista = false
    @State var apuntes = false
    @State var otro = false

    @State var activar: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("navBar").edgesIgnoringSafeArea(.all)
                
                ScrollView{
                    VStack{
                        Spacer()
                        VStack {
                            Button(action:{
                                activar = true
                            }){
                                MyNavigationView(texto: "Documentos recomendados")
                            }
                            
                            ScrollFilesView(files: files.filesRecomendados)
                            
                            NavigationLink("", destination: ListaFilesView(misArchivos: .recomendados), isActive: $activar)
                        }.onAppear{
                            files.getFilesRecomendados()
                        }
                        
                        NavigationTypeView(activar: $libro, tipo: "Libro")
                        NavigationTypeView(activar: $comic, tipo: "Comic")
                        NavigationTypeView(activar: $poema, tipo: "Poema")
                        NavigationTypeView(activar: $revista, tipo: "Revista")
                        NavigationTypeView(activar: $apuntes, tipo: "Apuntes")
                        NavigationTypeView(activar: $otro, tipo: "Otro")
                    }
                }.navigationBarTitle("Inicio", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text("FileChange").font(.headline).foregroundColor(Color.white)
                        }
                    }
                }
            }
        }.navigationBarColor(backgroundColor: UIColor(Color("navBarFuerte")), tintColor: UIColor(Color("itemTabBar")))
    }
}
