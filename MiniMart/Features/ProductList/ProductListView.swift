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
                List(vm.products) { product in
                    ProductRow(product: product)
                        .onTapGesture {
                            vm.selectProduct(product)
                        }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("MiniMart")
        .task {
            await vm.loadProducts()
        }
    }
}
