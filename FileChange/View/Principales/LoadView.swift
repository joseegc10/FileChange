//
//  LoadView.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 11/5/21.
//

import SwiftUI

struct LoadView: View {
    var body: some View {
        VStack{
            Text("FileChange")
                .font(.largeTitle)
                .foregroundColor(.white)
            
            Image("prueba")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
        }
    }
}
