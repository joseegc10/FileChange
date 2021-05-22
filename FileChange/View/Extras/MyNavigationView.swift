//
//  MyNavigationView.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 11/5/21.
//

import SwiftUI

struct MyNavigationView: View {
    var texto: String
    
    var body: some View {
        HStack {
            Text(texto)
                .font(.system(size: 25))
            
            Spacer()
            
            HStack {
                Image(systemName: "arrowtriangle.forward.fill")
            }
        }.padding(.horizontal)
        .foregroundColor(Color.white)
    }
}
