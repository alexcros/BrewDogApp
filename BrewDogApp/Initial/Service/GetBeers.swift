//
//  GetBeers.swift
//  BrewDogApp
//
//  Created by Alexandre on 12/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

protocol GetBeersProtocol {
    func invoke(completion: @escaping ([Beer]) -> Void)
}

struct GetBeers: GetBeersProtocol {
    
    private let repository: InitialService
    
    init(repository: InitialService) {
        self.repository = repository
    }
    
    func invoke(completion: @escaping ([Beer]) -> Void) {
        repository.getBeers { response, _ in
            guard let beers = response else { return }
            completion(beers)
        }
    }
}
