//
//  DetalleArticuloView.swift
//  DAMII_Proyecto
//
//  Created by FER on 12/12/24.
//

import SwiftUI

struct DetalleArticuloView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var articulo: Articulo
    @State private var mostrarAlerta = false
    @State private var mostrarFormulario = false
    
    var body: some View {
        VStack {
            List {
                Text("Nombre: \(articulo.nombre ?? "Sin nombre")")
                    .font(.headline)
                Text("Cantidad: \(articulo.cantidad)")
                    .font(.headline)
                Text("Prioridad: \(articulo.altaPrioridad ? "Alta" : "Baja")")
                    .font(.headline)
                let notasAdicionales = articulo.notasAdicionales ?? ""
                VStack(alignment: .leading) {
                    if !notasAdicionales.isEmpty {
                        Text("Notas Adicionales:")
                            .font(.headline)
                    }
                    Text(notasAdicionales.isEmpty ? "Sin notas Adicionales" : notasAdicionales)
                        .font(notasAdicionales.isEmpty ? .headline : .subheadline)
                }

            }
        }
        .alert(isPresented: $mostrarAlerta) {
            Alert(
                title: Text("¿Eliminar artículo '\(articulo.nombre ?? "Sin nombre")?"),
                message: Text("Esta acción no se puede deshacer"),
                primaryButton: .destructive(Text("Eliminar")) {
                    eliminarArticulo()
                },
                secondaryButton: .cancel()
            )
        }
        .navigationTitle("Detalles de Artículo")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    mostrarAlerta = true
                }) {
                    Image(systemName: "trash")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    mostrarFormulario = true
                }) {
                    Image(systemName: "pencil")
                }
            }
        }
        .sheet(isPresented: $mostrarFormulario) {
            EditarArticuloView(articulo: articulo, mostrar: $mostrarFormulario)
        }
    }
    
    private func eliminarArticulo() {
        do {
            viewContext.delete(articulo)
            try viewContext.save()
            dismiss()
        } catch {
            print("Error al eliminar: \(error)")
        }
    }
}
