//
//  ProductRow.swift
//  MiniMart
//
//  Created by Venkatesh on 5/17/26.
//

import SwiftUI

struct ProductRow: View {
    let product: Product
    var body: some View {
        HStack(spacing: 12) {
            CachedAsyncImage(url: URL(string: product.images.first ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView().frame(width: 60, height: 60)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                case .failure:
                    Image(systemName: "photo")
                        .frame(width: 60, height: 60)
                        .foregroundStyle(.secondary)
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.headline)
                    .lineLimit(2)
                Text(product.category)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("$\(product.price, format: .number.precision(.fractionLength(2)))")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.blue)
            }
            
            Spacer()
        }
    }
}

#Preview {
    ProductRow(product: Product(
        id: 1,
        title: "Sample Product",
        price: 109.95,
        description: "A great product",
        category: "Electronics",
        images: ["https://picsum.photos/200"],
        thumbnail: ""
    ))
}
