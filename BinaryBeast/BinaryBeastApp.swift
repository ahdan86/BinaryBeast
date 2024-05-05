//
//  BinaryGameMenuApp.swift
//  BinaryGameMenu
//
//  Created by Ahdan Amanullah on 26/04/24.
//

import SwiftUI
import SwiftData

@main
struct BinaryBeastApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [LevelData.self])
    }
}
