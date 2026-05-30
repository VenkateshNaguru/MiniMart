//
//  AddToCartUseCase.swift
//  MiniMart
//
//  Created by Venkatesh on 5/17/26.
//

import Foundation
import MiniMartCore

final class AddToCartUseCase {
    private let repository: CartRepositoryProtocol
    
    init(repository: CartRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(product: Product) {
        repository.addToCart(product)
    }
}
