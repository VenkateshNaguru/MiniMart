//
//  SearchViewModel.swift
//  MiniMart
//
//  Created by Venkatesh on 5/23/26.
//

import Combine
import Foundation
import MiniMartCore

class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var results: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let searchUseCase: SearchProductsUseCase
    private let analytics: AnalyticsServiceProtocol

    @ObservationIgnored
    private var cancellables = Set<AnyCancellable>()

    @ObservationIgnored
    private var searchTask: Task<Void, Never>?
    
    init(searchUseCase: SearchProductsUseCase,
         analytics: AnalyticsServiceProtocol) {
        self.searchUseCase = searchUseCase
        self.analytics = analytics
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
        analytics.log(.searchPerformed(query: query))
        
        do {
            results = try await searchUseCase.execute(query: query)
            analytics.log(.searchResultsReturned(
                query: query,
                count: results.count
            ))
        } catch {
            errorMessage = error.localizedDescription
            analytics.log(.errorOccurred(
                screen: "Search",
                error: error.localizedDescription
            ))
        }
    }
    
    @MainActor
    func clearSearch() {
        searchTask?.cancel()
        searchText = ""
        results = []
    }
}
