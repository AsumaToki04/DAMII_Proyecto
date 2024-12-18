//
//  ListaComprasView.swift
//  DAMII_Proyecto
//
//  Created by FER on 12/12/24.
//

import SwiftUI

struct ListaComprasView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Articulo.nombre, ascending: true)],
        animation: .default
    ) private var articulos: FetchedResults<Articulo>
    @State private var listaVacia: Bool = true
    
    @State private var mostrandoAcciones = false
    @State private var mostrarFormRegistro = false
    @State private var marcandoArticulos = false
    @State private var eliminandoArticulos = false
    
    @State private var articuloEliminar: Articulo?
    
    @StateObject private var categoriaViewModel = CategoriaViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    ForEach(articulos) { item in
                        HStack {
                            if !marcandoArticulos && !eliminandoArticulos {
                                NavigationLink(destination: DetalleArticuloView(articulo: item, categoriaViewModel: categoriaViewModel)) {
                                    ListaComprasItem(
                                        item: item,
                                        marcandoArticulos: $marcandoArticulos,
                                        eliminandoArticulos: $eliminandoArticulos,
                                        articuloEliminar: $articuloEliminar
                                    )
                                }
                            } else {
                                ListaComprasItem(
                                    item: item,
                                    marcandoArticulos: $marcandoArticulos,
                                    eliminandoArticulos: $eliminandoArticulos,
                                    articuloEliminar: $articuloEliminar
                                )
                            }
                        }
                        .alert(item: $articuloEliminar) { articulo in
                            Alert(
                                title: Text("¿Eliminar Artículo '\(articulo.nombre ?? "Sin nombre")'?"),
                                message: Text("Esta acción no se puede deshacer"),
                                primaryButton: .destructive(Text("Eliminar")) {
                                    eliminarArticulo(articulo)
                                },
                                secondaryButton: .cancel()
                            )
                        }
                        .listRowBackground(item.comprado ? Color.white.opacity(0.1) : Color.white)
                    }
                }
            }
            .onAppear {
                listaVacia = articulos.count == 0
            }
            .onChange(of: articulos.count) { nuevoValor in
                listaVacia = nuevoValor == 0
                if(listaVacia) {
                    marcandoArticulos = false
                    eliminandoArticulos = false
                }
            }
            if !eliminandoArticulos && !marcandoArticulos {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ExpandableFAB(
                            mostrandoBotones: $mostrandoAcciones,
                            mostrarFormRegistro: $mostrarFormRegistro,
                            marcandoArticulos: $marcandoArticulos,
                            eliminandoArticulos: $eliminandoArticulos,
                            listaVacia: $listaVacia
                        )
                    }
                }
            }
        }
        .navigationTitle("Lista de Compras")
        .toolbar {
            if marcandoArticulos || eliminandoArticulos {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        marcandoArticulos = false
                        eliminandoArticulos = false
                    }) {
                        Image(systemName: "xmark")
                    }
                }
            } else {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ResumenComprasView()) {
                        Image(systemName: "list.bullet.rectangle.portrait")
                    }
                }
            }
        }
        .sheet(isPresented: $mostrarFormRegistro) {
            RegistroArticuloView(mostrar: $mostrarFormRegistro,
                                 categoriaViewModel: categoriaViewModel)
        }
        .onDisappear {
            mostrandoAcciones = false
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
    
    private func eliminarArticulo(_ articulo: Articulo) {
        viewContext.delete(articulo)
        guardarCambios()
    }
}
