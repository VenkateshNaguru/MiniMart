//
//  AnalyticsService.swift
//  MiniMart
//
//  Created by Venkatesh on 6/6/26.
//

import Foundation

// Protocol — swap providers without changing feature code
protocol AnalyticsServiceProtocol {
    func log(_ event: AnalyticsEvent)
}

// Console implementation for MiniMart
// In production: replace with FirebaseAnalyticsService
final class ConsoleAnalyticsService: AnalyticsServiceProtocol {
    static let shared = ConsoleAnalyticsService()
    private init() {}

    func log(_ event: AnalyticsEvent) {
        #if DEBUG
        print("📊 [\(event.name)] \(event.parameters)")
        #endif
    }
}
