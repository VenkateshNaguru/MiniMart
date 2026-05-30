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
    var categories: [Category] = []
    var selectedCategory: Category? = nil
    var isLoading = false
    var errorMessage: String?
    
    private let fetchProductsUseCase: FetchProductsUseCase
    private let fetchCategoriesUseCase: FetchCategoriesUseCase
    var onProductSelected: ((Product) -> Void)?

    var filteredProducts: [Product] {
        guard let selected = selectedCategory else  {
            return products
        }

        return products.filter { $0.category.id == selected.id }
    }
    
    init(fetchProductsUseCase: FetchProductsUseCase,
         fetchCategoriesUseCase: FetchCategoriesUseCase) {
        self.fetchProductsUseCase = fetchProductsUseCase
        self.fetchCategoriesUseCase = fetchCategoriesUseCase
    }
    
    func loadProducts() async {
        isLoading = true
        
        defer { isLoading = false }
        do {
            async let products = fetchProductsUseCase.execute()
            async let categories = fetchCategoriesUseCase.execute()
            
            let (fetchedProducts, fetchedCategories) = try await (products, categories)

            self.products = fetchedProducts
            self.categories = fetchedCategories
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func selectedCategory(_ category: Category?) {
        selectedCategory = category
    }
    
    func selectProduct(_ product: Product) {
        onProductSelected?(product)
    }
}
