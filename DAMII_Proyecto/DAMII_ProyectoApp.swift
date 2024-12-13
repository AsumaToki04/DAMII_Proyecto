//
//  DAMII_ProyectoApp.swift
//  DAMII_Proyecto
//
//  Created by FER on 12/12/24.
//

import SwiftUI

@main
struct DAMII_ProyectoApp: App {
    let persistence = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(
                    \.managedObjectContext,
                     persistence.container.viewContext
                )
        }
    }
}
