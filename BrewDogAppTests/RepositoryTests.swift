//
//  RepositoryTests.swift
//  BrewDogAppTests
//
//  Created by Alexandre on 19/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import XCTest
@testable import BrewDogApp

class RepositoryTests: XCTestCase {

    var localBeers: [Beer]!
    var unsortedBeers: [Beer]!
    
    override func setUp() {
        localBeers = Repository.local.beers
        unsortedBeers = Repository.local.unsortedBeers
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocalRepositoryExistence() {
        XCTAssertNotNil(Repository.local)
    }
    
    func testLocalRepositoryBeersCreation() {
        
        XCTAssertNotNil(localBeers)
        
        XCTAssertEqual(localBeers.count, 4)
    }
    
    func testLocalRepository_ReturnsSortedArrayOfBeers() {
        XCTAssertEqual(localBeers, localBeers.sorted())
        
        XCTAssertNotEqual(localBeers, unsortedBeers)
    }

    func testLocalRepo_returnsBeersByName_CaseInsensitively() {
        
        let heineken = Repository.local.beer(named: "heineken")
        XCTAssertNil(heineken)
        
        guard let beer = Repository.local.beer(named: "BeEr1") else { return }
        XCTAssertEqual(beer.name, "beer1")
    }
}
