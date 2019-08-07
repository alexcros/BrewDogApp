//
//  CardView.swift
//  BrewDogApp
//
//  Created by Alexandre on 08/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit
import RxSwift

final class CardView: UIView, NibLoadableView {
    private enum Constants {
        static let height: CGFloat = 176
    }
    
    // MARK: - Outlets
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var abvLabel: UILabel!
    @IBOutlet var brewDogImageView: UIImageView!
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    
    // MARK: - Overrides
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: Constants.height)
    }
}
