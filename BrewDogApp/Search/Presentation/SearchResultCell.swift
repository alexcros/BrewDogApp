//
//  SearchResultCell.swift
//  BrewDogApp
//
//  Created by Alexandre on 08/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit
import RxSwift

final class SearchResultCell: UITableViewCell, ReusableView, NibLoadableView {
    // MARK: - Outlets
    
    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var abvLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tagLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    // MARK: - Properties
    
    private(set) var disposeBag = DisposeBag()
    
    // MARK: - Overrides
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
