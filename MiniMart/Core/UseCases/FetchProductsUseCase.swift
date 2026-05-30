//
//  FetchProductsUseCase.swift
//  MiniMart
//
//  Created by Venkatesh on 5/16/26.
//

import Foundation
import MiniMartCore

final class FetchProductsUseCase {
    private let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [Product] {
        let products = try await repository.fetchProducts()
        return products
    }
}

final class FetchProductDetailUseCase {
    private let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(id: Int) async throws -> Product {
        try await repository.fetchProduct(id: id)
    }
    
}

final class SearchProductsUseCase {
    private let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(query: String) async throws -> [Product] {
        guard !query.isEmpty else { return [] }
        return try await repository.searchProducts(title: query)
    }
}
