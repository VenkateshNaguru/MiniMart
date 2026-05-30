//
//  CategoryPill.swift
//  MiniMart
//
//  Created by Venkatesh on 5/30/26.
//

import SwiftUI

struct CategoryPill: View {
    let title: String
    let isSelected:  Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .background(isSelected ? Color(.blue) : Color(.systemGray6))
                .foregroundStyle(isSelected ? .white : .primary)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}
