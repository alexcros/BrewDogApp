//
//  BeerRealm.swift
//  BrewDogApp
//
//  Created by Alexandre on 14/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import RealmSwift

final class BeerRealm: Object {
    
    var identifier = RealmOptional<Int16>()
    @objc dynamic var name: String = ""
    @objc dynamic var tagline: String = ""
    @objc dynamic var query: String = ""
    @objc dynamic var beerDescription: String?
    @objc dynamic var imageUrl: String?
    var abv = RealmOptional<Double>()
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
}
