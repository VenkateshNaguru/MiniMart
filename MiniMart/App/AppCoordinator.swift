//
//  AppCoordinator.swift
//  MiniMart
//
//  Created by Venkatesh on 5/17/26.
//

import SwiftData
import SwiftUI
import Observation

@MainActor
@Observable
final class AppCoordinator {
    var path = NavigationPath()
    var productListViewModel: ProductListViewModel
    private let dependencies: DependencyContainer
    let analytics = ConsoleAnalyticsService.shared
    
    init(dependencies: DependencyContainer) {
        self.dependencies = dependencies
        
        let vm = ProductListViewModel(
            fetchProductsUseCase: dependencies.makeFetchProductUseCase(),
            fetchCategoriesUseCase: dependencies.makeFetchCategoriesUseCase(),
            analytics: analytics
        )
        self.productListViewModel = vm
        vm.onProductSelected = { [weak self] product in
            self?.navigateToDetail(product)
        }
    }

    func makeSearchView() -> SearchView {
        SearchView(
            searchUseCase: dependencies.makeSearchProductsUseCase(),
            analytics: analytics
        )
    }
    
    func navigateToDetail(_ product: Product) {
        path.append(product)
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func navigateToRoot() {
        path = NavigationPath()
    }
}
