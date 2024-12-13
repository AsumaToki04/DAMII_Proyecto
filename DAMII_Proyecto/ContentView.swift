//
//  ContentView.swift
//  DAMII_Proyecto
//
//  Created by FER on 12/12/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationView {
            ListaComprasView()
        }
    }
}
