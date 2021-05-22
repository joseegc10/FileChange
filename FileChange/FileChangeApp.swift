//
//  FileChangeApp.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 3/5/21.
//

import SwiftUI

@main
struct FileChangeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        let login = FirebaseAuth()
        WindowGroup {
            PrincipalView().environmentObject(login)
        }
    }
}
