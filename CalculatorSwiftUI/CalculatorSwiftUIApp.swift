//
//  CalculatorSwiftUIApp.swift
//  CalculatorSwiftUI
//
//  Created by Kirill Fedin on 14.11.2020.
//

import SwiftUI

@main
struct CalculatorSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            CalculatorView()
        }
    }
}
