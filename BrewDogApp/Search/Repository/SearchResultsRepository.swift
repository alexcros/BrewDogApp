//
//  SearchResultsRepository.swift
//  BrewDogApp
//
//  Created by Alexandre on 13/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import RxSwift
//import Reachability

// swiftlint:disable all
enum SearchError: Error {
    case searchNotFound
}

final class SearchResultsRepository {
    private let webService: WebService
    private lazy var beers: Observable<[Beer]> = Observable.just([])
    var arrayBeers = [Beer]()
    var anotherBeers = [Beer]()
    var disposeBag = DisposeBag()
//    private lazy var reachability = Reachability()
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func searchResultsOnDisk(withItems items: Observable<[Beer]>, ascending: Bool) -> Observable<[Beer]> {
        return items
            .map { beers -> [Beer] in
                if !beers.isEmpty {
                    self.anotherBeers = beers
                    self.arrayBeers = self.anotherBeers.sorted(by: { (beer1: Beer, beer2: Beer) -> Bool in return beer1.abv < beer2.abv })
                    print(self.arrayBeers)
                    return beers.sorted(by: { return $0.abv < $1.abv} )
                    //return beers.sorted(by: { return $0.abv < $1.abv} )
                } else {
                    return [Beer]()
                }
        }
    }
    
    func searchResultsOnDisk(withQuery query: String, ascending: Bool) -> Observable<[Beer]> {
        let predicate = NSPredicate(format: "query CONTAINS %@", query)
        let beers: [Beer] = ManagerDB.sharedInstance.getAllBeers(withPredicate: predicate, ascending: ascending)
        
        if !beers.isEmpty {
            return Observable.from(optional: beers)
        } else {
            return self.searchResults(withQuery: query)
        }
    }
    
    func searchResults(withQuery query: String) -> Observable<[Beer]> {
        return self.webService.load([Beer].self, withQuery: query, from: .food(name: query))
            .map { beers -> [Beer] in
                if !beers.isEmpty {
                    DispatchQueue.main.async {
                        ManagerDB.sharedInstance.save(beers: beers, with: query)
                    }
                    return beers.sorted(by: { return $0.abv < $1.abv} )
                } else {
                    return [Beer]()
                }
        }
    }
}
