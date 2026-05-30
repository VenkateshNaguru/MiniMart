//
//  Endpoint.swift
//  MiniMart
//
//  Created by Venkatesh on 5/16/26.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum Endpoint {
    case products
    case product(id: Int)
    case categories
    case productsByCategory(id: Int)
    case searchProducts(title: String)

    var path: String {
        switch self {
        case .products:
            return "/products"
        case .product(let id):
            return "/products/\(id)"
        case .categories:
            return "/categories"
        case .productsByCategory(let id):
            return "/categories/\(id)/products"
        case .searchProducts(let title):
            return "/products/?title=\(title)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .products, .product, .categories, .productsByCategory, .searchProducts:
            return .GET
        }
    }
}
