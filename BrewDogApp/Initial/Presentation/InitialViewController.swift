//
//  InitialViewController.swift
//  BrewDogApp
//
//  Created by Alexandre on 07/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa

class InitialViewController: UIViewController {
    // MARK: - Outlets
    
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var showsLabel: UILabel!
    @IBOutlet private var showsStackView: UIStackView!
    
    // MARK: - Properties
    
    private let presenter: InitialPresenter
    private let cardPresenter: CardPresenter
    private let searchNavigator: SearchNavigator
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialization
    
    init(presenter: InitialPresenter,
         searchNavigator: SearchNavigator,
         cardPresenter: CardPresenter) {
        self.presenter = presenter
        self.searchNavigator = searchNavigator
        self.cardPresenter = cardPresenter

        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        searchNavigator.installSearch(in: self)
        
        presenter.view = self
        presenter.didLoad()
    }
}

extension InitialViewController: InitialView {
    func setTitle(_ title: String) {
        self.title = title
    }

    func setShowsHeaderTitle(_ title: String) {
        showsLabel.text = title
    }

    func update(with beers: [Beer]) {
        showsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let cardViews: [UIView] = beers.map { beer in
            let cardView = CardView.instantiate()
            cardPresenter.present(beer: beer, in: cardView)
            cardView.tapGestureRecognizer.rx.event
                .subscribe({ [weak self] _ in
                    self?.presenter.didSelect(beer: beer)
                })
                .disposed(by: disposeBag)

            return cardView
        }

        cardViews.forEach { showsStackView.addArrangedSubview($0) }
    }
}
