//
//  ProductListView.swift
//  MiniMart
//
//  Created by Venkatesh on 5/16/26.
//

import SwiftUI

struct ProductListView: View {
    @Bindable var vm: ProductListViewModel
    
    var body: some View {
        Group {
            if vm.isLoading {
                ProgressView("Loading...")
            } else if let error = vm.errorMessage {
                Text("Error: \(error)")
                Button("Retry") {
                    Task {
                        await vm.loadProducts()
                    }
                }
            } else {
                
                categoryFilter

                VStack(spacing: 0) {
                    List(vm.filteredProducts) { product in
                        ProductRow(product: product)
                            .onTapGesture {
                                vm.selectProduct(product)
                            }
                    }
                    .listStyle(.plain)
                }
            }
        }
        .navigationTitle("MiniMart")
        .task {
            await vm.loadProducts()
        }
    }

    @ViewBuilder
    private var categoryFilter: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                CategoryPill(
                    title: "All",
                    isSelected: vm.selectedCategory == nil) {
                        vm.selectedCategory(nil)
                }
                
                ForEach(vm.categories) { category in
                    CategoryPill(
                        title: category.name,
                        isSelected: vm.selectedCategory?.id == category.id) {
                        vm.selectedCategory(category)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        .background(Color(.systemBackground))
    }
}
