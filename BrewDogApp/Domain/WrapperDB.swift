//
//  WrapperDB.swift
//  BrewDogApp
//
//  Created by Alexandre on 14/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit
import RealmSwift

final class WrapperDB: NSObject {
    
    func beerToRealm(beer: Beer, withQuery query: String) -> BeerRealm {
        
        let beerRealm = BeerRealm()
        
        beerRealm.query = query
        beerRealm.abv.value = beer.abv
        beerRealm.beerDescription = beer.description ?? ""
        beerRealm.identifier.value = beer.identifier
        beerRealm.imageUrl = beer.imageUrl ?? ""
        beerRealm.name = beer.name
        beerRealm.tagline = beer.tagline ?? ""
        
        return beerRealm
    }
    
    func beersDBFrom(beerModel: [Beer]) -> [BeerRealm] {
        
        let beerRealm = BeerRealm()
        var beersRealm = [BeerRealm]()
        
        for beer in beerModel {
            beerRealm.abv.value = beer.abv
            beerRealm.beerDescription = beer.description ?? ""
            beerRealm.identifier.value = beer.identifier
            beerRealm.imageUrl = beer.imageUrl ?? ""
            beerRealm.name = beer.name
            beerRealm.tagline = beer.tagline ?? ""
            
            beersRealm.append(beerRealm)
        }
        
        return beersRealm
    }
    
    func beerFrom(beerRealm: BeerRealm) -> Beer {
        
        let beer = Beer(identifier: beerRealm.identifier.value ?? 0,
                        name: beerRealm.name,
                        tagline: beerRealm.tagline,
                        description: beerRealm.beerDescription ?? "",
                        imageUrl: beerRealm.imageUrl ?? "",
                        abv: beerRealm.abv.value ?? 0.0)
        return beer
    }
}
