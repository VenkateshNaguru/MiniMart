//
//  AnalyticsEvent.swift
//  MiniMart
//
//  Created by Venkatesh on 6/6/26.
//

import Foundation

enum AnalyticsEvent {

    // MARK: - Screen Events
    case screenViewed(name: String)

    // MARK: - Product Events
    case productViewed(id: Int, title: String)
    case productAddedToCart(id: Int, title: String, price: Double)

    // MARK: - Search Events
    case searchPerformed(query: String)
    case searchResultsReturned(query: String, count: Int)

    // MARK: - Category Events
    case categorySelected(name: String)
    case categoryCleared

    // MARK: - Cart Events
    case cartViewed(itemCount: Int, totalPrice: Double)
    case cartItemRemoved(id: Int, title: String)
    case cartQuantityChanged(id: Int, quantity: Int)

    // MARK: - Error Events
    case errorOccurred(screen: String, error: String)

    // MARK: - Event name + parameters
    var name: String {
        switch self {
        case .screenViewed:          return "screen_viewed"
        case .productViewed:         return "product_viewed"
        case .productAddedToCart:    return "product_added_to_cart"
        case .searchPerformed:       return "search_performed"
        case .searchResultsReturned: return "search_results_returned"
        case .categorySelected:      return "category_selected"
        case .categoryCleared:       return "category_cleared"
        case .cartViewed:            return "cart_viewed"
        case .cartItemRemoved:       return "cart_item_removed"
        case .cartQuantityChanged:   return "cart_quantity_changed"
        case .errorOccurred:         return "error_occurred"
        }
    }

    var parameters: [String: Any] {
        switch self {
        case .screenViewed(let name):
            return ["screen_name": name]
        case .productViewed(let id, let title):
            return ["product_id": id, "title": title]
        case .productAddedToCart(let id, let title, let price):
            return ["product_id": id, "title": title, "price": price]
        case .searchPerformed(let query):
            return ["query": query]
        case .searchResultsReturned(let query, let count):
            return ["query": query, "result_count": count]
        case .categorySelected(let name):
            return ["category_name": name]
        case .categoryCleared:
            return [:]
        case .cartViewed(let count, let total):
            return ["item_count": count, "total_price": total]
        case .cartItemRemoved(let id, let title):
            return ["product_id": id, "title": title]
        case .cartQuantityChanged(let id, let quantity):
            return ["product_id": id, "quantity": quantity]
        case .errorOccurred(let screen, let error):
            return ["screen": screen, "error": error]
        }
    }
}
