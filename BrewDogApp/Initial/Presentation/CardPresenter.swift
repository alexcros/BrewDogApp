//
//  CardPresenter.swift
//  BrewDogApp
//
//  Created by Alexandre on 08/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import RxSwift
import RxCocoa
import Kingfisher

/// Presents Beer in card views
final class CardPresenter {
    func present(beer: Beer, in cardView: CardView) {
        bindBackdrop(at: beer.imageUrl, to: cardView)
        cardView.titleLabel.text = beer.name.uppercased()
        cardView.abvLabel.text = [String(beer.abv), beer.tagline]
            .compactMap { $0 }
            .joined(separator: " ⋅ ")
    }
}

private extension CardPresenter {
    func bindBackdrop(at path: String?, to cardView: CardView) {
        guard let path = path else {
            return
        }
        cardView.brewDogImageView.kf.setImage(with: URL(string: path))
    }
}
