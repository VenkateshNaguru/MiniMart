//
//  ProductListViewModel.swift
//  MiniMart
//
//  Created by Venkatesh on 5/16/26.
//

import Foundation
import Observation

@MainActor
@Observable
class ProductListViewModel {
    var products: [Product] = []
    var isLoading = false
    var errorMessage: String?
    
    private let fetchProductsUseCase: FetchProductsUseCase
    var onProductSelected: ((Product) -> Void)?
    
    init(fetchProductsUseCase: FetchProductsUseCase) {
        self.fetchProductsUseCase = fetchProductsUseCase
    }
    
    func loadProducts() async {
        isLoading = true
        
        defer { isLoading = false }
        do {
            products = try await fetchProductsUseCase.execute()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func selectProduct(_ product: Product) {
        onProductSelected?(product)
    }
}
