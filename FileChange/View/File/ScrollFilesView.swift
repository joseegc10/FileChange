//
//  ScrollFilesView.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 5/5/21.
//

import SwiftUI

struct ScrollFilesView: View {
    var files: [FileModel]
    @State private var miFile = FileModel()
    
    var body: some View {
        ScrollView(.horizontal){
            HStack {
                ForEach(files, id: \.self.id, content: { file in
                    FileCardView(file: file)
                        .onTapGesture {
                            miFile = file
                        }
                    
                    Divider()
                })
            }
        }
    }
}
