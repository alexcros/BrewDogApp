//
//  InitialAssembly.swift
//  BrewDogApp
//
//  Created by Alexandre on 07/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

final public class InitialAssembly {
    private let repository: InitialService
    private let searchAssembly: SearchAssembly
    
    init(repository: InitialService,
         searchAssembly: SearchAssembly) {
        self.repository = repository
        self.searchAssembly = searchAssembly
    }
    
    func getBeers() -> GetBeersProtocol {
        return GetBeers(repository: repository)
    }
    
    func presenter() -> InitialPresenter {
        let initial = InitialPresenter()
        initial.getBeers = getBeers()
        
        return initial
    }
    
    public func viewController() -> UIViewController {
        return InitialViewController(presenter: presenter(),
                                     searchNavigator: searchAssembly.searchNavigator(),
                                     cardPresenter: cardPresenter())
    }
    
    func cardPresenter() -> CardPresenter {
        return CardPresenter()
    }
}
