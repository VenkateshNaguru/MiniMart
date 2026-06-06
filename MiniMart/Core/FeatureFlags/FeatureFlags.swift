//
//  FeatureFlags.swift
//  MiniMart
//
//  Created by Venkatesh on 6/5/26.
//

import Foundation

enum Feature: String {
    case searchEnabled = "feature_search_enabled"
    case categoryFilter = "feature_category_filter"
    case cartBadge = "feature_cart_badge"
}

final class FeatureFlags {
    static let shared = FeatureFlags()

    private init() {}
    
    // Local flags - hardcoded for now
    private let flags: [Feature: Bool] = [
        .searchEnabled: true,
        .categoryFilter: true,
        .cartBadge: true
    ]
    
    func isEnabled(_ feature: Feature) -> Bool {
        return flags[feature] ?? false
    }
}
