//
//  DateFormatter+Custom.swift
//  BrewDogApp
//
//  Created by Alexandre on 23/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let beersAPIDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
