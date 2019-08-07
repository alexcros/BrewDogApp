//
//  InitialService.swift
//  BrewDogApp
//
//  Created by Alexandre on 12/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

protocol InitialService {
    func getBeers(completion: @escaping (_ response: [Beer]?, _ error: Error?) -> Void)
}
