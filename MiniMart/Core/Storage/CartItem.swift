//
//  CartItem.swift
//  MiniMart
//
//  Created by Venkatesh on 5/23/26.
//

import Foundation
import SwiftData

@Model
class CartItem {
    var id: UUID
    var productId: Int
    var productTitle: String
    var productPrice: Double
    var productImage: String
    var quantity: Int
    
    init(product: Product) {
        self.id = UUID()
        self.productId = product.id
        self.productTitle = product.title
        self.productPrice = product.price
        self.productImage = product.images.first ?? ""
        self.quantity = 1
    }
    
    var totalPrice: Double {
        productPrice * Double(quantity)
    }
}

extension CartItem {
    func asProduct() -> Product {
        Product(
            id: productId,
            title: productTitle,
            price: productPrice,
            description: "",
            category: Category(id: 0, name: "", image: ""),
            images: [productImage]
        )
    }
}
