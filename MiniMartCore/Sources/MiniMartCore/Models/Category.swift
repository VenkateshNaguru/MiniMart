//
//  Category.swift
//  MiniMart
//
//  Created by Venkatesh on 5/30/26.
//

import Foundation

public struct Category: Codable, Identifiable, Hashable {
    public let id: Int
    public let name: String
    public let image: String

    public init(id: Int, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
}
