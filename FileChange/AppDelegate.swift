//
//  AppDelegate.swift
//  FileChange
//
//  Created by Jose Alberto Garcia Collado on 3/5/21.
//

import UIKit
import Firebase

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
