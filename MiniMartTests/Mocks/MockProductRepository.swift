//
//  MockProductRepository.swift
//  MiniMart
//
//  Created by Venkatesh on 5/30/26.
//

import Foundation
@testable import MiniMart

final class MockProductRepository: ProductRepositoryProtocol {
    var stubbedProducts: [Product] = []
    var stubbedCategories: [MiniMart.Category] = []
    var shouldThrow = false

    func fetchProducts() async throws -> [Product] {
        if shouldThrow { throw URLError(.notConnectedToInternet) }
        return stubbedProducts
    }

    func fetchProduct(id: Int) async throws -> MiniMart.Product {
        if shouldThrow { throw URLError(.networkConnectionLost) }
        guard let product = stubbedProducts.first(where: { $0.id == id }) else {
            throw URLError(.fileDoesNotExist)
        }
        
        return product
    }

    func searchProducts(title: String) async throws -> [MiniMart.Product] {
        if shouldThrow { throw URLError(.networkConnectionLost) }
        
        return stubbedProducts.filter {
            $0.title.lowercased().contains(title.lowercased())
        }
    }

    func fetchCategories() async throws -> [MiniMart.Category] {
        if shouldThrow { throw URLError(.notConnectedToInternet) }
        return stubbedCategories
    }
}
