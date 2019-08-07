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
    
    var beerArray: [Beer] = []
    var beerUnsortedArray: [Beer] = []
    
    var beerOne: Beer!
    var beerTwo: Beer!
    var beerThree: Beer!
    var beerFour: Beer!
    var beerFive: Beer!
    
    override func setUp() {
        
        beerOne = Beer(identifier: 12,
                       name: "Arcade Nation",
                       tagline: "Seasonal Black IPA.",
                       description: "Running",
                       imageUrl: "",
                       abv: 5.3)
        
        beerTwo = Beer(identifier: 1,
                       name: "Hobo Pop",
                       tagline: "2013 Prototype Rye Pale Ale.",
                       description: "Brewed",
                       imageUrl: "",
                       abv: 4.2)
        
        beerThree = Beer(identifier: 2, name: "Kohatu")
        beerFour = Beer(identifier: 3, name: "Cranachan Cream Ale")
        beerFive = Beer(identifier: 4, name: "Dortmunder")
        
        beerUnsortedArray.append(beerTwo)
        beerUnsortedArray.append(beerOne)
        beerUnsortedArray.append(beerThree)
        beerUnsortedArray.append(beerFour)
        beerUnsortedArray.append(beerFive)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBeerName() {
        XCTAssertEqual(beerFive.name, "Dortmunder")
        XCTAssertEqual(beerFour.name, "Cranachan Cream Ale")
    }
    
    func testBeer_addBeers_returnsTheCorrectCountOfBeers() {
        XCTAssertEqual(beerArray.count, 0)
        
        beerArray.append(beerTwo)
        beerArray.append(beerThree)
        XCTAssertEqual(beerArray.count, 2)
        
        beerArray.append(beerFour)
        beerArray.append(beerFive)
        XCTAssertEqual(beerArray.count, 4)
    }
    
    func testBeerExistence() {
        XCTAssertNotNil(beerOne)
    }
    
    func testBeerEquality() {
        XCTAssertEqual(beerOne, beerOne)
        
        let beerEquality = Beer(identifier: 12,
                                name: "Arcade Nation",
                                tagline: "Seasonal Black IPA.",
                                description: "Running ",
                                imageUrl: "",
                                abv: 5.3)
        
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
        XCTAssertEqual(beerArray, beerArray.sorted())
        
        XCTAssertNotEqual(beerArray, beerUnsortedArray)
    }
}
