//
//  ProductListViewModel.swift
//  MiniMart
//
//  Created by Venkatesh on 5/16/26.
//

import Foundation
import MiniMartCore
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
    private let analytics: AnalyticsServiceProtocol

    var onProductSelected: ((Product) -> Void)?

    var filteredProducts: [Product] {
        guard let selected = selectedCategory else  {
            return products
        }

        return products.filter { $0.category == selected.slug }
    }
    
    init(fetchProductsUseCase: FetchProductsUseCase,
         fetchCategoriesUseCase: FetchCategoriesUseCase,
         analytics: AnalyticsServiceProtocol) {
        self.fetchProductsUseCase = fetchProductsUseCase
        self.fetchCategoriesUseCase = fetchCategoriesUseCase
        self.analytics = analytics
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
            analytics.log(.screenViewed(name: "ProductList"))
        } catch {
            errorMessage = error.localizedDescription
            analytics.log(.errorOccurred(
                        screen: "ProductList",
                        error: error.localizedDescription
                    ))
        }
    }

    func selectedCategory(_ category: Category?) {
        if let category {
            analytics.log(.categorySelected(name: category.name))
        } else {
            analytics.log(.categoryCleared)
        }
        selectedCategory = category
    }
    
    func selectProduct(_ product: Product) {
        analytics.log(.productViewed(
            id: product.id,
            title: product.title
        ))
        onProductSelected?(product)
    }
}
