//
//  CartViewModel.swift
//  MiniMart
//
//  Created by Venkatesh on 5/24/26.
//

import Foundation
import MiniMartCore
import Observation
import SwiftData

@MainActor
@Observable
class CartViewModel {
    var cartItems: [CartItem] = []
    var totalPrice: Double = 0

    private let repository: CartRepositoryProtocol
    private let analytics: AnalyticsServiceProtocol

    init(repository: CartRepositoryProtocol,
         analytics: AnalyticsServiceProtocol) {
        self.repository = repository
        self.analytics = analytics
    }

    func loadItems() {
        cartItems = repository.fetchCartItems()
        totalPrice = cartItems.reduce(0) { $0 + $1.totalPrice }
    }

    func addToCart(_ product: Product) {
        repository.addToCart(product)
        loadItems()
        analytics.log(.productAddedToCart(
            id: product.id,
            title: product.title,
            price: product.price
        ))
    }

    func removeFromCart(_ product: Product) {
        repository.removeFromCart(product)
        loadItems()
    }

    func increaseQuantity(_ item: CartItem) {
        repository.updateQuantity(item: item, quantity: item.quantity + 1)
        totalPrice = cartItems.reduce(0) { $0 + $1.totalPrice }
    }

    func decreaseQuantity(_ item: CartItem) {
        if item.quantity > 1 {
            repository.updateQuantity(item: item, quantity: item.quantity - 1)
            totalPrice = cartItems.reduce(0) { $0 + $1.totalPrice }
        } else {
            repository.removeFromCart(item.asProduct())
            loadItems()
        }
    }

    func clearCart() {
        repository.clearCart()
        cartItems = []
        totalPrice = 0
    }

    var totalItems: Int {
        cartItems.reduce(0) { $0 + $1.quantity }
    }
    
}
