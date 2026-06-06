//
//  ProductRepository.swift
//  MiniMart
//
//  Created by Venkatesh on 5/16/26.
//

import Foundation

protocol ProductRepositoryProtocol {
    func fetchProducts() async throws -> [Product]
    func fetchProduct(id: Int) async throws -> Product
    func searchProducts(title: String) async throws -> [Product]
    func fetchCategories() async throws -> [Category]
}

final class ProductRepository: ProductRepositoryProtocol {
    private var networkClient = NetworkClient()
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func fetchProducts() async throws -> [Product] {
        let response: ProductResponse = try await networkClient.fetch(endpoint: .products)
        return response.products
    }
    
    func fetchProduct(id: Int) async throws -> Product {
        try await networkClient.fetch(endpoint: .product(id: id))
    }
    
    func searchProducts(title: String) async throws -> [Product] {
        let response: ProductResponse = try await networkClient.fetch(endpoint: .searchProducts(query: title))
        return response.products
    }

    func fetchCategories() async throws -> [Category] {
        try await networkClient.fetch(endpoint: .categories)
    }
}
