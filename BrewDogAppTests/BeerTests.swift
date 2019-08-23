//
//  BeerTests.swift
//  BrewDogAppTests
//
//  Created by Alexandre on 18/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import XCTest
@testable import BrewDogApp

class BeerTests: XCTestCase {
    
    var emptyCollection: [Beer] = []
    var beerSortedCollection: [Beer] = []
    
    var beerOne: Beer!
    var beerTwo: Beer!
    var beerThree: Beer!
    var beerFour: Beer!
    var beerFive: Beer!
    
    override func setUp() {
        
        guard let path = Bundle.main.path(forResource: "beer-response", ofType: "json") else {
            XCTFail("beer-response isn't found")
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            beerSortedCollection = try decoder.decode([Beer].self, from: data)
        } catch {
            XCTFail("Error decoding data")
        }
        
        beerOne = beerSortedCollection.first
        beerTwo = beerSortedCollection[1]
        beerThree = beerSortedCollection[2]
        beerFour = beerSortedCollection[3]
        beerFive = beerSortedCollection[4]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDecodeBeerArray() {
        
        XCTAssertNotNil(beerSortedCollection)
        
        for beer in beerSortedCollection {
            XCTAssertNotNil(beer.abv)
            XCTAssertNotNil(beer.description)
            XCTAssertNotNil(beer.hashValue)
            XCTAssertNotNil(beer.identifier)
            XCTAssertNotNil(beer.imageUrl ?? "")
            XCTAssertNotNil(beer.name)
            XCTAssertNotNil(beer.tagline)
        }
    }
    
    func testBeerName() {
        XCTAssertEqual(beerFive.name, "Avery Brown Dredge")
        XCTAssertEqual(beerFour.name, "Pilsen Lager")
    }
    
    func testBeer_addBeers_returnsTheCorrectCountOfBeers() {
        XCTAssertEqual(emptyCollection.count, 0)

        emptyCollection.append(beerThree)
        emptyCollection.append(beerTwo)
        
        XCTAssertEqual(emptyCollection.count, 2)
    }
    
    func testBeerExistence() {
        XCTAssertNotNil(beerOne)
    }
    
    func testBeerEquality() {
        XCTAssertEqual(beerOne, beerOne)
        
        let beerEquality = Repository.local.beers.last
        
        XCTAssertEqual(beerOne, beerEquality)
        
        XCTAssertNotEqual(beerOne, beerTwo)
        
    }
    
    func testBeerHashable() {
        XCTAssertNotNil(beerTwo.hashValue)
    }
    
    func testBeerComparison() {
        XCTAssertLessThan(beerOne, beerTwo)
    }
    
    func testBeer_sorted_ReturnsSortedArray() {
        XCTAssertEqual(emptyCollection, emptyCollection.sorted())
        
        XCTAssertNotEqual(emptyCollection, beerSortedCollection)
    }
    
}
