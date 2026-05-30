//
//  FetchCategoriesUseCase.swift
//  MiniMart
//
//  Created by Venkatesh on 5/30/26.
//

import Foundation

final class FetchCategoriesUseCase {
    private let repository: ProductRepositoryProtocol

    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [Category] {
        let categories = try await repository.fetchCategories()
        return categories
    }
}
