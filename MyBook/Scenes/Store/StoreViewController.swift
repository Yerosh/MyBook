//
//  StoreViewController.swift
//  MyBook
//
//  Created by Yernur Adilbek on 3/30/24.
//

import UIKit
import SnapKit

class StoreViewController: UIViewController {
    var manager = BookManager()
    var bookResults: [BookData.Item] = []
    
    var searchText: String = ""
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        searchController.searchBar.delegate = self
        searchController.searchBar.backgroundImage = UIImage()
        return searchController
    }()
    
    private lazy var bookTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(StoreTableViewCell.self, forCellReuseIdentifier: "store")
        tableView.backgroundColor = .clear
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        setupUI()
        
        bookTableView.dataSource = self
        bookTableView.delegate = self
        
        manager.delegate = self
//        manager.fetchHealthBooks(maxResults: 5)
        manager.fetchSearchInput(searchInput: searchText)
        view.backgroundColor = UIColor(red: 28/255, green: 23/255, blue: 47/255, alpha: 1)
    }

}

extension StoreViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Update the searchText property whenever the text changes
        self.searchText = searchText
        manager.fetchSearchInput(searchInput: searchText)
        bookTableView.reloadData()
    }
}

//MARK: - Table view data source methods
extension StoreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "store", for: indexPath) as! StoreTableViewCell
        cell.configure(with: bookResults[indexPath.row])
        cell.backgroundColor = .clear
        return cell
    }
}


//MARK: - Table view delegate methods
extension StoreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.configure(with: bookResults[indexPath.row])
        present(detailVC, animated: true)
    }
    
}

extension StoreViewController: FetchBooksDelegate {
    func didUpdateBooks(with results: [BookData.Item]) {
        self.bookResults = results
        DispatchQueue.main.async { [self] in
            bookTableView.reloadData()
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}


// MARK: - setting iui methods
private extension StoreViewController {
    func setupUI() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.addSubview(bookTableView)
    }
    
    func setupConstraints() {
        bookTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
