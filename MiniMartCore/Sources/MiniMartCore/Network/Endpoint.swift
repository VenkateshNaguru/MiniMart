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
    case productsByCategory(name: String)
    case searchProducts(query: String)

    var path: String {
        switch self {
        case .products:
            return "/products"
        case .product(let id):
            return "/products/\(id)"
        case .categories:
            return "/products/categories"
        case .productsByCategory(let name):
            return "/products/category/\(name)"
        case .searchProducts(let query):
            let encoded = query.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed
            )
            return "/products/search?q=\(encoded ?? "")"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .products, .product, .categories, .productsByCategory, .searchProducts:
            return .GET
        }
    }
}
