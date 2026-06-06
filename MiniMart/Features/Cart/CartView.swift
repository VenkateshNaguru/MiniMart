//
//  CartView.swift
//  MiniMart
//
//  Created by Venkatesh on 5/24/26.
//

import SwiftData
import SwiftUI

struct CartView: View {
    @Environment(\.modelContext) private var context
    @State private var vm: CartViewModel?

    var body: some View {
        NavigationStack {
            Group {
                if let vm = vm {
                    cartContent(vm: vm)
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("Cart")
            .onAppear {
                if vm == nil {
                    vm = CartViewModel(
                        repository: SwiftDataCartRepository(context: context),
                        analytics: ConsoleAnalyticsService.shared
                    )
                    vm?.loadItems()
                }
            }
        }
    }
    
    @ViewBuilder
    private func cartContent(vm: CartViewModel) -> some View {
        if vm.cartItems.isEmpty {
            VStack(spacing: 8) {
                Spacer()
                Image(systemName: "cart")
                    .font(.largeTitle)
                    .foregroundStyle(.foreground)
                Text("Your cart is empty")
                    .foregroundStyle(.secondary)
                Spacer()
            }
        } else {
            VStack {
                List {
                    ForEach(vm.cartItems) { item in
                        CartItemRow(item: item, vm: vm)
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let item = vm.cartItems[index]
                            vm.removeFromCart(item.asProduct())
                        }
                    }
                }
                .listStyle(.plain)
                
                VStack(spacing: 12) {
                    HStack {
                        Text("Total")
                            .fontWeight(.bold)
                        Spacer()
                        Text("$\(vm.totalPrice, format: .number.precision(.fractionLength(2)))")
                            .fontWeight(.bold)
                            .foregroundStyle(.blue)
                    }
                    
                    Button {
                        vm.clearCart()
                    } label: {
                        Text("Clear Cart")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.red.opacity(0.1))
                            .foregroundStyle(.red)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .buttonStyle(.borderless)
                }
                .padding()
                .background(.background)
            }
        }
    }
}

struct CartItemRow: View {
    let item: CartItem
    let vm: CartViewModel

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: item.productImage)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                default:
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.gray.opacity(0.2))
                        .frame(width: 50, height: 50)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.productTitle)
                    .font(.headline)
                    .lineLimit(1)
                Text("$\(item.productPrice, format: .number.precision(.fractionLength(2)))")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            HStack(spacing: 8) {
                Button {
                    vm.decreaseQuantity(item)
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .foregroundStyle(.blue)
                }
                .buttonStyle(.borderless)

                Text("\(item.quantity)")
                    .font(.headline)
                    .frame(minWidth: 20)

                Button {
                    vm.increaseQuantity(item)
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundStyle(.blue)
                }
                .buttonStyle(.borderless)
            }
        }
        .padding(.vertical, 4)
    }
}
