//
//  SearchResultsRepository.swift
//  BrewDogApp
//
//  Created by Alexandre on 13/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import RxSwift

// swiftlint:disable all
enum SearchError: Error {
    case searchNotFound
}

final class SearchResultsRepository {
    private let webService: WebService
    private lazy var beers: Observable<[Beer]> = Observable.just([])
    private var disposeBag = DisposeBag()
    
    init(webService: WebService) {
        self.webService = webService
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
    
    private func searchResults(withQuery query: String) -> Observable<[Beer]> {
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
