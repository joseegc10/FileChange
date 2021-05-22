//
//  TiposPickerView.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 5/5/21.
//

import SwiftUI

struct Tipo: Hashable {
    let id: Int
    var title: String
    var selected: Bool
    
    init (id: Int, title: String, selected: Bool) {
        self.id = id
        self.title = title
        self.selected = selected
    }
}

struct TiposPickerView: View {
    var Categories: [Tipo] = []
    var lastIndex: Int = 0

    @Binding var selectedTitle: String
    @State var currentIndex: Int = 0
    @Namespace private var ns
    
    var index = 0
    
    let tipoInicial: String
    
    init(selectedTitle: Binding<String>, tipoInicial: String) {
        _selectedTitle = selectedTitle
        self.tipoInicial = tipoInicial
        Categories.removeAll()
        
        if tipoInicial == "Libro" {
            index = 0
            Categories.append(Tipo(id: 0, title: "Libro", selected: true))
        } else {
            Categories.append(Tipo(id: 0, title: "Libro", selected: false))
        }
        
        if tipoInicial == "Comic" {
            index = 1
            Categories.append(Tipo(id: 1, title: "Comic", selected: true))
        } else {
            Categories.append(Tipo(id: 1, title: "Comic", selected: false))
        }
        
        if tipoInicial == "Poema" {
            index = 2
            Categories.append(Tipo(id: 2, title: "Poema", selected: true))
        } else {
            Categories.append(Tipo(id: 2, title: "Poema", selected: false))
        }
        
        if tipoInicial == "Revista" {
            index = 3
            Categories.append(Tipo(id: 3, title: "Revista", selected: true))
        } else {
            Categories.append(Tipo(id: 3, title: "Revista", selected: false))
        }
        
        if tipoInicial == "Apuntes" {
            index = 4
            Categories.append(Tipo(id: 4, title: "Apuntes", selected: true))
        } else {
            Categories.append(Tipo(id: 4, title: "Apuntes", selected: false))
        }

        if tipoInicial == "Otro" {
            index = 5
            Categories.append(Tipo(id: 5, title: "Otro", selected: true))
        } else {
            Categories.append(Tipo(id: 5, title: "Otro", selected: false))
        }
    }
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                
                ScrollViewReader { scrollView in
                    
                    HStack(spacing: 35) {
                        
                        ForEach(Categories, id: \.self) { item in
                            if item.id == currentIndex {
                                ZStack() {
                                    Text(item.title)
                                        .bold()
                                        .layoutPriority(1)
                                    VStack() {
                                        Rectangle().frame(height: 2)
                                            .padding(.top, 20)
                                    }
                                    .matchedGeometryEffect(id: "animation", in: ns)
                                }.foregroundColor(.white)
                            } else {
                                Text(item.title)
                                    .foregroundColor(.white)
                                    .onTapGesture {
                                        withAnimation {
                                            currentIndex = item.id
                                            selectedTitle = item.title
                                            scrollView.scrollTo(item)
                                        }
                                    }
                            }
                        }
                    }
                    .padding(.leading, 10)
                    .padding(.trailing, 20)
                }
            }
        }
        .padding()
        .onAppear{
            currentIndex = index
        }
    }
    
}
