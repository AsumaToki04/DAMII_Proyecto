//
//  RegistroArticuloView.swift
//  DAMII_Proyecto
//
//  Created by FER on 12/12/24.
//

import SwiftUI

struct RegistroArticuloView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var mostrar: Bool
    @State private var mensajeError: String = ""
    
    @State private var nombre: String = ""
    @State private var cantidad: Int16 = 0
    @State private var textoCantidad: String = ""
    @State private var altaPrioridad: Bool = false
    @State private var notasAdicionales: String = ""
    @State private var categoria: String = "Seleccionar categoría"
    
    @ObservedObject var categoriaViewModel: CategoriaViewModel
    
    var body: some View {
        NavigationView {
            if categoriaViewModel.estaCargando {
                ProgressView("Cargando...")
            } else if let error = categoriaViewModel.mensajeError {
                VStack {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.headline)
                }
                .navigationTitle("Registrar Artículo")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancelar") {
                            mostrar = false
                        }
                    }
                }
            } else {
                Form {
                    VStack(alignment: .leading) {
                        CustomTextField01(placeholder: "Nombre", texto: $nombre)
                        CustomTextField01(placeholder: "Cantidad", texto: $textoCantidad)
                        Picker("", selection: $categoria) {
                            Text("Seleccionar categoría").tag("Seleccionar categoría")
                            ForEach(categoriaViewModel.categorias) { item in
                                Text(item.name).tag(item.name)
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .labelsHidden()
                        .border(.gray)
                        .cornerRadius(2)
                        CustomTextField01(placeholder: "Notas Adicionales", texto: $notasAdicionales)
                        CustomToggle01(text: "Alta Prioridad", isOn: $altaPrioridad)
                        CustomButton01(
                            text: "Guardar",
                            action: {
                                procesarFormulario()
                            }
                        )
                    }
                    if !mensajeError.isEmpty {
                        VStack {
                            Text(mensajeError)
                                .foregroundColor(.red)
                        }
                        .listRowBackground(Color.clear)
                    }
                    
                }
                .onChange(of: textoCantidad) { nuevoValor in
                    if let nuevaCantidad = Int16(nuevoValor), nuevaCantidad > 0 {
                        cantidad = nuevaCantidad
                    } else {
                        cantidad = 0
                    }
                }
                .navigationTitle("Registrar Artículo")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancelar") {
                            mostrar = false
                        }
                    }
                }
            }
        }
        .onAppear {
            categoriaViewModel.fetchCategorias()
        }
    }
    
    private func procesarFormulario() {
        if nombre.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            mensajeError = "Ingresar nombre"
        } else if cantidad == 0 {
            mensajeError = "Ingresar una cantidad válida"
        } else if categoria == "Seleccionar categoría" {
            mensajeError = "Seleccionar categoría"
        } else {
            registrarArticulo()
        }
    }
    
    private func registrarArticulo() {
        let articulo = Articulo(context: viewContext)
        articulo.id = UUID()
        articulo.nombre = nombre.trimmingCharacters(in: .whitespacesAndNewlines)
        articulo.cantidad = cantidad
        articulo.categoria = categoria
        articulo.altaPrioridad = altaPrioridad
        articulo.notasAdicionales = notasAdicionales.trimmingCharacters(in: .whitespacesAndNewlines)
        do {
            try viewContext.save()
            mostrar = false
        } catch {
            print("Ocurrió un error al guardar: \(error)")
        }
    }
}
