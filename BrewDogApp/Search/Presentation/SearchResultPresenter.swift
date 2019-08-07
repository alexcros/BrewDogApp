//
//  SearchResultPresenter.swift
//  BrewDogApp
//
//  Created by Alexandre on 08/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Kingfisher
import RxSwift
import RxCocoa

/// Presents search results in cells
final class SearchResultPresenter {
    
    private enum Constants {
        static let throttle = 1.0
        static let minimumQueryLength = 3
    }
    
    private let repository: SearchResultsRepository
    let query = Variable("")
    var disposeBag = DisposeBag()
    
    init(repository: SearchResultsRepository) {
        self.repository = repository
    }
    /// The search results
    private(set) lazy var searchResults: Observable<[Beer]> = query.asObservable()
        .debug()
        .distinctUntilChanged()
        .throttle(Constants.throttle, scheduler: MainScheduler.instance)
        .flatMapLatest { [weak self] query -> Observable<[Beer]> in
            guard let `self` = self,
                query.count >= Constants.minimumQueryLength else {
                    return Observable.just([])
            }
          
            return self.repository.searchResultsOnDisk(withQuery: query, ascending: true)
        }
        .observeOn(MainScheduler.instance)
    
    func present(beer: Beer, in cell: SearchResultCell) {
        cell.abvLabel.text = String("\(beer.abv) º")
        cell.titleLabel.text = beer.name
        cell.tagLabel.text = beer.tagline
        cell.descriptionLabel.text = beer.description
        
        bindImage(at: beer.imageUrl, to: cell)
    }
}

private extension SearchResultPresenter {
    func bindImage(at path: String?, to cell: SearchResultCell) {
        guard let path = path else {
            return
        }
        cell.beerImageView.kf.setImage(with: URL(string: path))
    }
}
