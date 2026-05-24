//
//  SwiftDataCartRepository.swift
//  MiniMart
//
//  Created by Venkatesh on 5/23/26.
//

import Foundation
import SwiftData


final class SwiftDataCartRepository: CartRepositoryProtocol {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }
    
    func addToCart(_ product: Product) {
        let existing = fetchCartItems().first {
            $0.productId == product.id
        }
        
        if let existing = existing {
            existing.quantity += 1
        } else {
            let newItem = CartItem(product: product)
            context.insert(newItem)
        }
        try? context.save()
    }

    func removeFromCart(_ product: Product) {
        let items = fetchCartItems()
        if let item = items.first(where: { $0.productId == product.id }) {
            context.delete(item)
            try? context.save()
        }
    }

    func fetchCartItems() -> [CartItem] {
        let descriptor = FetchDescriptor<CartItem>()
        return (try? context.fetch(descriptor)) ?? []
    }

    func updateQuantity(item: CartItem, quantity: Int) {
        item.quantity = quantity
        try? context.save()
    }

    func clearCart() {
        let items = fetchCartItems()
        items.forEach { context.delete($0) }
        try? context.save()
    }
}
