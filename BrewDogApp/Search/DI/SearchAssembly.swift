//
//  SearchAssembly.swift
//  BrewDogApp
//
//  Created by Alexandre on 08/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

final class SearchAssembly {
    private let searchResultsRepository: SearchResultsRepository

    init(searchResultsRepository: SearchResultsRepository) {
        self.searchResultsRepository = searchResultsRepository
    }

    func searchNavigator() -> SearchNavigator {
        return SearchNavigator(searchViewControllerProvider: self)
    }
    
    func presenter() -> SearchResultPresenter {
        return SearchResultPresenter(repository: searchResultsRepository)
    }
    
    func resultPresenter() -> SearchResultPresenter {
        let searchResultPresenter = SearchResultPresenter(repository: searchResultsRepository)
        return searchResultPresenter
    }
}

extension SearchAssembly: SearchViewControllerProvider {
    func searchViewController() -> UIViewController {
        return SearchViewController(presenter: presenter())
    }
}
