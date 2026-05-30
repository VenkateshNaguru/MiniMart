//
//  ProductListViewModelTests.swift
//  MiniMart
//
//  Created by Venkatesh on 5/30/26.
//

import Testing
@testable import MiniMart

@MainActor
struct ProductListViewModelTests {
    
    // MARK: - Helpers
    func makeVM(
        products: [Product] = [],
        categories: [Category] = [],
        shouldThrow: Bool = false
    ) -> ProductListViewModel {
        let repo = MockProductRepository()
        repo.stubbedProducts = products
        repo.stubbedCategories = categories
        repo.shouldThrow = shouldThrow
        
        return ProductListViewModel(
            fetchProductsUseCase: FetchProductsUseCase(repository: repo),
            fetchCategoriesUseCase: FetchCategoriesUseCase(repository: repo)
        )
    }
    
    func makeSampleProducts() -> [Product] {
        [
            Product(id: 1, title: "Shirt",
                    price: 20, description: "A shirt",
                    category: Category(id: 1, name: "Clothes", image: ""),
                    images: []),
            Product(id: 2, title: "Phone",
                    price: 500, description: "A phone",
                    category: Category(id: 2, name: "Electronics", image: ""),
                    images: []),
            Product(id: 3, title: "Jeans",
                    price: 40, description: "Jeans",
                    category: Category(id: 1, name: "Clothes", image: ""),
                    images: [])
        ]
    }
    
    @Test func loadProducts_setsProducts() async {
        let products = makeSampleProducts()
        let vm = makeVM(products: products)
        
        await vm.loadProducts()
        
        #expect(vm.products.count == 3)
    }
    
    @Test func loadProducts_setsCategories() async {
        let categories = [
            Category(id: 1, name: "Clothes", image: ""),
            Category(id: 2, name: "Electronics", image: "")
        ]
        let vm = makeVM(
            products: makeSampleProducts(),
            categories: categories
        )
        
        await vm.loadProducts()
        
        #expect(vm.categories.count == 2)
    }
    
    @Test func loadProducts_setsError_onFailure() async {
        let vm = makeVM(shouldThrow: true)
        
        await vm.loadProducts()
        
        #expect(vm.errorMessage != nil)
        #expect(vm.products.isEmpty)
    }
    
    @Test func loadProducts_setsIsLoading_false_afterLoad() async {
        let vm = makeVM(products: makeSampleProducts())
        
        await vm.loadProducts()
        
        #expect(vm.isLoading == false)
    }
    @Test func filteredProducts_returnsAll_whenNoCategorySelected() async {
        let vm = makeVM(products: makeSampleProducts())
        await vm.loadProducts()
        
        #expect(vm.filteredProducts.count == 3)
    }
    
    @Test func filteredProducts_filtersCorrectly_whenCategorySelected() async {
        let vm = makeVM(products: makeSampleProducts())
        await vm.loadProducts()
        
        let clothes = Category(id: 1, name: "Clothes", image: "")
        vm.selectedCategory(clothes)
        
        #expect(vm.filteredProducts.count == 2) // Shirt + Jeans
        #expect(vm.filteredProducts.allSatisfy {
            $0.category.id == 1
        })
    }
    
    @Test func selectCategory_nil_showsAllProducts() async {
        let vm = makeVM(products: makeSampleProducts())
        await vm.loadProducts()
        
        let clothes = Category(id: 1, name: "Clothes", image: "")
        vm.selectedCategory(clothes)
        vm.selectedCategory(nil)  // back to All
        
        #expect(vm.filteredProducts.count == 3)
    }
}
