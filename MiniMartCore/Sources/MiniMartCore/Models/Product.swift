//
//  Product.swift
//  MiniMart
//
//  Created by Venkatesh on 5/16/26.
//

import Foundation

public struct Product: Codable, Identifiable, Hashable {
    public let id: Int
    public let title: String
    public let price: Double
    public let description: String
    public let category: String
    public let images: [String]
    public let thumbnail: String

    public init(id: Int, title: String, price: Double,
                description: String, category: String,
                images: [String], thumbnail: String) {
        self.id = id
        self.title = title
        self.price = price
        self.description = description
        self.category = category
        self.images = images
        self.thumbnail = thumbnail
    }
}

public struct ProductResponse: Codable {
    public let products: [Product]
}


