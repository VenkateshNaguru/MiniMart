//
//  MockCartRepository.swift
//  MiniMart
//
//  Created by Venkatesh on 5/18/26.
//

import Foundation

final class MockCartRepository: CartRepositoryProtocol {
    private var items: [CartItem] = []

    func addToCart(_ product: Product) {
        if let index = items.firstIndex(where: { $0.productId == product.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(product: product))
        }
    }
    
    func removeFromCart(_ product: Product) {
        items.removeAll() { $0.productId == product.id }
    }
    
    func fetchCartItems() -> [CartItem] {
        items
    }

    func updateQuantity(item: CartItem, quantity: Int) {
        item.quantity = quantity
    }
    
    func clearCart() {
        items.removeAll()
    }
}
