//
//  CartRepository.swift
//  MiniMart
//
//  Created by Venkatesh on 5/17/26.
//

import Foundation
import MiniMartCore

protocol CartRepositoryProtocol {
    func addToCart(_ product: Product)
    func removeFromCart(_ product: Product)
    func fetchCartItems() -> [CartItem]
    func updateQuantity(item: CartItem, quantity: Int)
    func clearCart()
}
