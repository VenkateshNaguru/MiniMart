//
//  Category.swift
//  MiniMart
//
//  Created by Venkatesh on 5/30/26.
//

import Foundation

public struct Category: Codable, Identifiable, Hashable {
    public let slug: String
    public let name: String
    public let url: String
    
    public var id: String { slug }

    public init(slug: String, name: String, url: String) {
        self.slug = slug
        self.name = name
        self.url = url
    }
}
