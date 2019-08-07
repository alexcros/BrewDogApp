//
//  ManagerDB.swift
//  BrewDogApp
//
//  Created by Alexandre on 14/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import RealmSwift

// swiftlint:disable force_try
final class ManagerDB: NSObject {
    static let sharedInstance = ManagerDB()
    private let wrapper = WrapperDB()
    private let realm = try! Realm()
    
    func deleteBeers() {
         let beersRealm: Results<BeerRealm> = {
            realm.objects(BeerRealm.self)
        }()
        
        try! realm.write {
            realm.delete(beersRealm)
        }
    }

    func save(beers: [Beer], with query: String) {
            var beersRealm = [BeerRealm]()
            for beer: Beer in beers {
                let beerRealm = self.wrapper.beerToRealm(beer: beer, withQuery: query)
                beersRealm.append(beerRealm)
            }
    
            try! self.realm.write { () -> Void in
                self.realm.add(beersRealm, update: .all)
            }
    }
    
    func getAllBeers(withPredicate: NSPredicate, ascending: Bool) -> [Beer] {
        
        let beersRealm: Results<BeerRealm> = {
            realm.objects(BeerRealm.self)
                .sorted(byKeyPath: "abv", ascending: ascending)
                .filter(withPredicate)
        }()
       
        if beersRealm.isEmpty {
            return [Beer]()
        }
        
        let beers = NSMutableArray()
        
        for beer in beersRealm {
            beers.add(wrapper.beerFrom(beerRealm: beer))
        }
        // swiftlint:disable force_cast
        return beers.copy() as! [Beer]
    }
}
