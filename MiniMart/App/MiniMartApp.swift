//
//  MiniMartApp.swift
//  MiniMart
//
//  Created by Venkatesh on 5/13/26.
//

import SwiftUI
import SwiftData

@main
struct MiniMartApp: App {
    @State private var coordinator = AppCoordinator(
            dependencies: DependencyContainer()
        )
    var body: some Scene {
        WindowGroup {
            MainTabView(coordinator: coordinator)
        }
        .modelContainer(for: CartItem.self)
    }
}
