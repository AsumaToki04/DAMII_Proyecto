//
//  CategoriaService.swift
//  DAMII_Proyecto
//
//  Created by DAMII on 17/12/24.
//

import Foundation
import Alamofire

class CategoriaService {
    static let shared = CategoriaService()
    private init() {}
    
    private let urlBase = "https://jsonplaceholder.typicode.com"
    
    func fetchCategorias() async throws -> [Categoria] {
        try await withCheckedThrowingContinuation { continuation in
            AF.request("\(urlBase)/users")
                .validate()
                .responseDecodable(of: [Categoria].self) { response in
                    switch response.result {
                    case .success(let categorias):
                        continuation.resume(returning: categorias)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
