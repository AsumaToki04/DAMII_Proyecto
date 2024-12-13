//
//  Persistence.swift
//  DAMII_Proyecto
//
//  Created by FER on 12/12/24.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    init(){
        container = NSPersistentContainer(name: "DAMII_Proyecto")
        container.loadPersistentStores { _, error in
            if let er = error as? NSError {
                fatalError("No se pudo conectar a la BD: \(er)")
            }
        }
    }
}
