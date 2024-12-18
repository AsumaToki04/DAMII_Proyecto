//
//  CategoriaViewModel.swift
//  DAMII_Proyecto
//
//  Created by DAMII on 17/12/24.
//

import Foundation

@MainActor
class CategoriaViewModel: ObservableObject {
    @Published var categorias: [Categoria] = []
    @Published var estaCargando = false
    @Published var mensajeError: String?
    
    func fetchCategorias() {
        Task {
            do {
                estaCargando = true
                mensajeError = nil
                categorias = try await CategoriaService.shared.fetchCategorias()
            } catch {
                mensajeError = error.localizedDescription
            }
            estaCargando = false
        }
    }
}
