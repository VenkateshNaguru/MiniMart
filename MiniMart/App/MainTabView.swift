//
//  MainTabView.swift
//  MiniMart
//
//  Created by Venkatesh on 5/17/26.
//

import SwiftUI

struct MainTabView: View {
    var coordinator: AppCoordinator

    var body: some View {
        TabView {
            NavigationStack(path: Bindable(coordinator).path) {
                ProductListView(vm: coordinator.productListViewModel)
                    .navigationDestination(for: Product.self) { product in
                        ProductDetailView(
                            product: product
                        )
                    }
            }
            .tabItem {
                Label("Products", systemImage: "house.fill")
            }
            // Search tab - feature flagged
            if FeatureFlags.shared.isEnabled(.searchEnabled) {
                coordinator.makeSearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
            }
            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart.fill")
                }
        }
    }
}
