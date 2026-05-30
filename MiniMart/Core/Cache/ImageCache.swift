//
//  ImageCache.swift
//  MiniMart
//
//  Created by Venkatesh on 5/30/26.
//

import SwiftUI

actor ImageCache {
    static let shared = ImageCache()

    private let cache = NSCache<NSString, UIImage>()

    private init() {
        cache.countLimit = 100
        cache.totalCostLimit = 50 * 1024 * 1024
    }

    func image(for url: URL) async throws -> Image {
        let key = url.absoluteString as NSString

        // Cache hit - return immediately
        if let cached = cache.object(forKey: key) {
            return Image(uiImage: cached)
        }

        // Cache miss - download
        let (data, _) = try await URLSession.shared.data(from: url)

        guard let image = UIImage(data: data) else {
            throw ImageCacheError.invalidData
        }

        // Store in cache
        cache.setObject(image, forKey: key)

        return Image(uiImage: image)
    }
}

enum ImageCacheError: Error {
    case invalidData
}
