//
//  InitialPresenter.swift
//  BrewDogApp
//
//  Created by Alexandre on 08/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import RxSwift

protocol InitialView: class {
    func setShowsHeaderTitle(_ title: String)
    func update(with beers: [Beer])
}

final class InitialPresenter {
    // MARK: - Properties
    
    weak var view: InitialView?
    var getBeers: GetBeersProtocol!
    
    func didLoad() {
        view?.setShowsHeaderTitle(NSLocalizedString("HI! JUST TYPE A FOOD ON THE SEARCH BAR! :)", comment: ""))
        
        populateBeers()
    }
    
    func didSelect(beer: Beer) {
        print(beer.identifier)
    }
}

private extension InitialPresenter {
    func populateBeers() {
        getBeers.invoke { [weak self] beers in
            DispatchQueue.main.async {
                self?.view?.update(with: beers)
            }
        }
    }
}
