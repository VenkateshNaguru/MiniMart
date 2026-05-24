//
//  SearchView.swift
//  MiniMart
//
//  Created by Venkatesh on 5/23/26.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var vm: SearchViewModel
    
    init(searchUseCase: SearchProductsUseCase) {
        _vm = StateObject(wrappedValue: SearchViewModel(searchUseCase: searchUseCase))
    }

    var body: some View {
        NavigationStack {
            VStack {
                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.secondary)
                    TextField("Search products...", text: $vm.searchText)
                        .textFieldStyle(.plain)
                    
                    if !vm.searchText.isEmpty {
                        Button {
                            vm.clearSearch()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding()
                .background(.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
                
                // Content
                if vm.isLoading {
                    Spacer()
                    ProgressView("Searching...")
                    Spacer()
                } else if vm.searchText.isEmpty {
                    Spacer()
                    VStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)
                        Text("Search for products")
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                } else if vm.results.isEmpty {
                    Spacer()
                    VStack(spacing: 8) {
                        Image(systemName: "tray")
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)
                        Text("No results for '\(vm.searchText)'")
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                } else {
                    List(vm.results) { product in
                        ProductRow(product: product)
                    }
                    .listStyle(.plain)
                }
            }
        }
        .navigationTitle("Search")
    }
}
