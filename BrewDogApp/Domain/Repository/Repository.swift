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
        
        beers.append(Beer(identifier: 1, name: "Beer1"))
        beers.append(Beer(identifier: 2, name: "beer2"))
        beers.append(Beer(identifier: 3, name: "beer3"))
        
        return beers
    }

    var unsortedBeers: [Beer] {
        
        var beers = [Beer]()
        
        beers.append(Beer(identifier: 2, name: "beer2"))
        beers.append(Beer(identifier: 1, name: "beer1"))
        
        return beers
    }
}
