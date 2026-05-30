//
//  ImageCache.swift
//  MiniMart
//
//  Created by Venkatesh on 5/30/26.
//

import SwiftUI

struct CachedAsyncImage<Content: View>: View {
    let url: URL?
    let content: (AsyncImagePhase) -> Content

    @State private var phase: AsyncImagePhase = .empty

    init(url: URL?,
         @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        self.url = url
        self.content = content
    }
    
    var body: some View {
        content(phase)
            .task(id: url) {
                await loadImage()
            }
    }

    private func loadImage() async {
        guard let url else {
            phase = .empty
            return
        }
        do {
            let image = try await ImageCache.shared.image(for: url)
            phase = .success(image)
        } catch {
            phase = .failure(error)
        }
    }
}
