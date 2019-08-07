//
//  CoreAssembly.swift
//  BrewDogApp
//
//  Created by Alexandre on 07/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

final public class CoreAssembly {
    
    private lazy var webServiceAssembly: WebServiceAssembly = WebServiceAssembly()
    private(set) lazy var webService = webServiceAssembly.webService
    public private(set) lazy var initialAssembly = InitialAssembly(repository: webService, searchAssembly: searchAssembly)
    private(set) lazy var searchAssembly = SearchAssembly(searchResultsRepository: searchResultsRepo)
    private(set) lazy var searchResultsRepo = SearchResultsRepository(webService: webService)
    
    private let navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
