//
//  DependencyContainer.swift
//  MiniMart
//
//  Created by Venkatesh on 5/14/26.
//

import Foundation
import MiniMartCore

final class DependencyContainer {
    init() {}
        
    // MARK: - Network
    lazy var networkClient: NetworkClient = {
        NetworkClient()
    }()

    // MARK: - Repositories
    lazy var productRespository: ProductRepositoryProtocol = {
        ProductRepository(networkClient: networkClient)
    }()
    
    lazy var cartRepository: CartRepositoryProtocol = {
        MockCartRepository()
    }()

    // MARK: - UseCases
    func makeFetchProductUseCase() -> FetchProductsUseCase {
        FetchProductsUseCase(repository: productRespository)
    }

    func makeSearchProductsUseCase() -> SearchProductsUseCase {
        SearchProductsUseCase(repository: productRespository)
    }

    func makeAddToCartUseCase() -> AddToCartUseCase {
        AddToCartUseCase(repository: cartRepository)
    }

    func makeFetchCategoriesUseCase() -> FetchCategoriesUseCase {
        FetchCategoriesUseCase(repository: productRespository)
    }
}
