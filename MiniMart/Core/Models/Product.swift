//
//  Product.swift
//  MiniMart
//
//  Created by Venkatesh on 5/16/26.
//

import Foundation

struct Product: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category
    let images: [String]
}

struct Category: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let image: String
}
