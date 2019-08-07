//
//  SearchViewController.swift
//  BrewDogApp
//
//  Created by Alexandre on 08/08/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import RxSwift
import RxCocoa

protocol SearchViewControllerProvider: class {
    func searchViewController() -> UIViewController
}

/// Displays search results
class SearchViewController: UITableViewController {
    
    // MARK: - Properties
    
    private let presenter: SearchResultPresenter
    private let disposeBag = DisposeBag()
    private var beers = [Beer]()
    
    // MARK: - Initialization
    
    init(presenter: SearchResultPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindPresenters()
    }
    
    @objc func buttonAction(_ sender: UIButton!) {
//        tableView.dataSource = nil
//
//        presenter.order(withItems: Observable.just(beers)).bind(to: tableView.rx.items) { tableView, _, item in
//            let cell = tableView.dequeueReusableCell(SearchResultCell.self)
//            self.presenter.present(beer: item, in: cell)
//            return cell
//            }.disposed(by: disposeBag)
    
    }
}

// MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // Update the search query as the user types
        presenter.query.value = searchController.searchBar.text ?? ""
    }
}

// MARK: - Private

private extension SearchViewController {
    enum Constants {
        static let separatorInset = UIEdgeInsets(top: 0, left: 64, bottom: 0, right: 0)
        static let rowHeight: CGFloat = 200
    }
    
    func setupView() {
        tableView.register(SearchResultCell.self)
        tableView.separatorInset = Constants.separatorInset
        tableView.rowHeight = Constants.rowHeight
        self.clearDelegateAndDataSource()
        
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        customView.backgroundColor = UIColor.gray
        let sortButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        sortButton.setTitle("Sort", for: .normal)
        sortButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        customView.addSubview(sortButton)
        tableView.tableHeaderView = customView
    }
    
    func clearDelegateAndDataSource() {
        tableView.dataSource = nil
        tableView.delegate = nil
    }
    
    func bindPresenters() {
        // Bind the search results to the table view data source
        presenter.searchResults
            .bind(to: tableView.rx.items) { [weak self] tableView, _, searchResult in
                let cell = tableView.dequeueReusableCell(SearchResultCell.self)
                self?.beers.append(searchResult)
                self?.presenter.present(beer: searchResult, in: cell)
                return cell
            }
            .disposed(by: disposeBag)
    }
}
