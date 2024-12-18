//
//  ListaComprasItemView.swift
//  DAMII_Proyecto
//
//  Created by FER on 12/12/24.
//

import SwiftUI

struct ListaComprasItem: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var item: Articulo
    @Binding var marcandoArticulos: Bool
    @Binding var eliminandoArticulos: Bool
    @Binding var articuloEliminar: Articulo?
    
    var body: some View {
        VStack(alignment: .leading) {
            let nombre = item.nombre ?? "Sin nombre"
            let prioridad = item.altaPrioridad ? "Alta" : "Baja"
            let notasAdicionales = item.notasAdicionales ?? ""
            let tieneNotas = notasAdicionales.isEmpty ? "No" : "Sí"
            let categoria = item.categoria ?? "Sin categoría"
            CustomText01(texto: nombre, comprado: item.comprado, esHeadline: false)
            CustomText01(texto: "Cantidad: \(item.cantidad)", comprado: item.comprado)
            CustomText01(texto: "Categoría: \(categoria)", comprado: item.comprado)
            CustomText01(texto: "Prioridad: \(prioridad)", comprado: item.comprado)
            CustomText01(texto: "Notas Adicionales: \(tieneNotas)", comprado: item.comprado)
        }
        Spacer()
        if marcandoArticulos {
            Button(action: {
                item.comprado.toggle()
                guardarCambios()
            }) {
                let icono = item.comprado ? "checkmark.circle.fill" : "circle"
                let colorIcono = item.comprado ? Color.green : Color.gray
                Image(systemName: icono)
                    .foregroundColor(colorIcono)
            }
        }
        if eliminandoArticulos {
            Button(action: {
                articuloEliminar = item
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
    }
    
    private func guardarCambios() {
        viewContext.perform {
            do {
                try viewContext.save()
            } catch {
                print("Error al guardar: \(error)")
            }
        }
    }
}
