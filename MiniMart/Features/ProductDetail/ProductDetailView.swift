//
//  ProductDetailView.swift
//  MiniMart
//
//  Created by Venkatesh on 5/17/26.
//

import SwiftUI

struct ProductDetailView: View {
    @Environment(\.modelContext) private var context
    let product: Product
    @State private var vm: ProductDetailViewModel?

    var body: some View {
        Group {
            if let vm = vm {
                productContent(vm: vm)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            if vm == nil {
                vm = ProductDetailViewModel(
                    product: product,
                    addToCartUseCase: AddToCartUseCase(
                        repository: SwiftDataCartRepository(context: context)
                    )
                )
            }
        }
    }

    @ViewBuilder
    private func productContent(vm: ProductDetailViewModel) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // Product Image
                CachedAsyncImage(url: URL(string: vm.product.images.first ?? "")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .frame(height: 300)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .frame(height: 300)
                    case .failure:
                        Image(systemName: "photo")
                            .frame(maxWidth: .infinity)
                            .frame(height: 300)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    // Title
                    Text(vm.product.title)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    // Category
                    Text(vm.product.category.name)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(.blue.opacity(0.1))
                        .foregroundStyle(.blue)
                        .clipShape(Capsule())
                    
                    // Price
                    Text("$\(vm.product.price, format: .number.precision(.fractionLength(2)))")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.blue)
                    
                    // Description
                    Text(vm.product.description)
                        .font(.body)
                        .foregroundStyle(.secondary)
                    
                    // Add to Cart Button
                    Button {
                        vm.addToCart()
                    } label: {
                        HStack {
                            Image(systemName: vm.isAddedToCart ? "checkmark": "cart.badge.plus")
                            Text(vm.isAddedToCart ? "Added to Cart": "Add to Cart")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(vm.isAddedToCart ? .green : .blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(vm.product.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
