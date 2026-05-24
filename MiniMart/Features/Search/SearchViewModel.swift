//
//  SearchViewModel.swift
//  MiniMart
//
//  Created by Venkatesh on 5/23/26.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var results: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let searchUseCase: SearchProductsUseCase

    @ObservationIgnored
    private var cancellables = Set<AnyCancellable>()

    @ObservationIgnored
    private var searchTask: Task<Void, Never>?
    
    init(searchUseCase: SearchProductsUseCase) {
        self.searchUseCase = searchUseCase
        setupSearchPipeline()
    }
    
    private func setupSearchPipeline() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .filter( { !$0.isEmpty })
            .sink { [weak self] query in
                self?.searchTask?.cancel()
                self?.searchTask =  Task {
                    await self?.search(query)
                }
                
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    func search(_ query: String) async {
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        do {
            results = try await searchUseCase.execute(query: query)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    @MainActor
    func clearSearch() {
        searchTask?.cancel()
        searchText = ""
        results = []
    }
}
