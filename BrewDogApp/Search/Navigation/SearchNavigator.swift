//
//  SearchNavigator.swift
//  BrewDogApp
//
//  Created by Alexandre on 08/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

final class SearchNavigator {
    private unowned let searchViewControllerProvider: SearchViewControllerProvider
    private var searchController: UISearchController!
    
    init(searchViewControllerProvider: SearchViewControllerProvider) {
        self.searchViewControllerProvider = searchViewControllerProvider
    }
    
    func installSearch(in viewController: UIViewController) {
        let searchViewController = searchViewControllerProvider.searchViewController()
        searchController = UISearchController(searchResultsController: searchViewController)
        searchController.searchResultsUpdater = searchViewController as? UISearchResultsUpdating
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("Search regarding your food...", comment: "")
        
        viewController.navigationItem.titleView = searchController.searchBar
        viewController.definesPresentationContext = true
    }
}
