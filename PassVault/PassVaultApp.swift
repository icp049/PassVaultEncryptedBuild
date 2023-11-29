//
//  PassVaultApp.swift
//  PassVault
//
//  Created by Ian Pedeglorio on 2023-11-28.
//

import SwiftUI

@main
struct PassVaultApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
