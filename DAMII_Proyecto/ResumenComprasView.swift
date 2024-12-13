//
//  ResumenComprasView.swift
//  DAMII_Proyecto
//
//  Created by FER on 12/12/24.
//

import SwiftUI

struct ResumenComprasView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Articulo.nombre, ascending: true)],
        predicate: NSPredicate(format: "comprado == true")
    ) private var comprados: FetchedResults<Articulo>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Articulo.nombre, ascending: true)],
        predicate: NSPredicate(format: "comprado == false")
    ) private var pendientes: FetchedResults<Articulo>
    var body: some View {
        VStack {
            List {
                let totalArticulos = comprados.count + pendientes.count
                Text("Total de artículos: \(totalArticulos)")
                Text("Artículos Comprados: \(comprados.count)")
                Text("Artículos Pendientes: \(pendientes.count)")
            }
        }
        .navigationTitle("Resumen de Compras")
    }
}
