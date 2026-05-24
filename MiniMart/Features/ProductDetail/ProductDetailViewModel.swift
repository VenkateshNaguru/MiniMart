//
//  ProductDetailViewModel.swift
//  MiniMart
//
//  Created by Venkatesh on 5/17/26.
//

import SwiftUI
import Observation

@MainActor
@Observable
class ProductDetailViewModel {
    var product: Product
    var isAddedToCart = false
    
    private let addToCartUseCase: AddToCartUseCase
    
    init(product: Product, addToCartUseCase: AddToCartUseCase) {
        self.product = product
        self.addToCartUseCase = addToCartUseCase
    }
    
    func addToCart() {
        addToCartUseCase.execute(product: product)
        isAddedToCart = true
    }
}
