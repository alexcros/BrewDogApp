//
//  Beer.swift
//  BrewDogApp
//
//  Created by Alexandre on 07/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

struct Beer: Codable {
    let identifier: Int16
    let name: String
    let tagline: String?
    let description: String?
    let imageUrl: String?
    let abv: Double
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case tagline
        case description
        case imageUrl = "image_url"
        case abv
    }
    
    init(identifier: Int16, name: String, tagline: String, description: String, imageUrl: String, abv: Double) {
        self.identifier = identifier
        self.name = name
        self.tagline = tagline
        self.description = description
        self.imageUrl = imageUrl
        self.abv = abv
    }
    
    init(identifier: Int16, name: String) {
        self.init(identifier: identifier,
                  name: name,
                  tagline: "tag",
                  description: "desc",
                  imageUrl: "",
                  abv: 5.0)
    }

}

// MARK: - Proxy

extension Beer {
    var proxyForEquality: String {
        return "\(name)\(identifier)\(abv)"
    }
    
    var proxyForComparison: String {
        return name.lowercased()
    }
}

// MARK: - Equatable

extension Beer: Equatable {
    static func == (lhs: Beer, rhs: Beer) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

// MARK: - Hashable identifier

extension Beer: Hashable {
    func hash(into hasher: inout Hasher) { // try static
        hasher.combine(proxyForEquality.hashValue)
    }
}

// MARK: - Comparable

extension Beer: Comparable {
    static func < (lhs: Beer, rhs: Beer) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
