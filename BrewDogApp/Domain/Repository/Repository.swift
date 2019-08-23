//
//  Repository.swift
//  BrewDogApp
//
//  Created by Alexandre on 19/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

final class Repository {
    static let local = LocalFactory()
}

// MARK: - BeerFactory

protocol BeerFactory {
    
    var beers: [Beer] { get }
    
    var unsortedBeers: [Beer] { get }
    
    func beer(named: String) -> Beer?
    
}
// MARK: - LocalFactory

final class LocalFactory: BeerFactory {
    func beer(named: String) -> Beer? {
        return beers.first { $0.name == named.lowercased() }
    }
    
    var beers: [Beer] {
        
        var beers = [Beer]()

        beers.append(Beer(identifier: 0, name: "Beer1", abv: 5.0))
        beers.append(Beer(identifier: 3, name: "Beer2", abv: 4.0))
        beers.append(Beer(identifier: 4, name: "Beer1", abv: 9.0))
        beers.append(Beer(identifier: 1,
             name: "Buzz",
             tagline: "A Real Bitter Experience.",
             description: "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once. ",
             imageUrl: "https://images.punkapi.com/v2/keg.png",
             abv: 4.5))
        
        return beers
    }

    var unsortedBeers: [Beer] {
        
        var beers = [Beer]()
        
        beers.append(Beer(identifier: 2, name: "beer2", abv: 3.0))
        beers.append(Beer(identifier: 1, name: "beer1", abv: 3.0))
        
        return beers
    }
}
