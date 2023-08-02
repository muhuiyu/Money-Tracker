//
//  PickerViewController.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/7/22.
//

import UIKit

class PickerViewController: BaseViewController {
    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView = UITableView()
    
    private let options: [String]
    private let text: String
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    private var filteredOptions = [String]()
    
    var didPickOption: ((String) -> Void)?
    
    init(text: String, options: [String]) {
        self.text = text
        self.options = options
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
    }
}
// MARK: - View Config
extension PickerViewController {
    private func configureViews() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        
        navigationItem.searchController = searchController
        navigationItem.setTitle(text)
        navigationItem.setBarButtonItem(at: .left,
                                        with: Localized.General.cancel,
                                        isBold: false,
                                        target: self,
                                        action: #selector(didTapCancel))
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    private func configureConstraints() {
        tableView.snp.remakeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    @objc
    private func didTapCancel() {
        dismiss(animated: true)
    }
}

// MARK: - Data Source
extension PickerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredOptions.count : options.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let optionList = isFiltering ? filteredOptions : options
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        var content = cell.defaultContentConfiguration()
        content.text = optionList[indexPath.row]
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - Delegate
extension PickerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        let optionList = isFiltering ? filteredOptions : options
        didPickOption?(optionList[indexPath.row])
        dismiss(animated: true)
    }
}

// MARK: - SearchController
extension PickerViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        filterOptionForSearchText(searchText)
    }
    func filterOptionForSearchText(_ searchText: String) {
        filteredOptions = options.filter({
            $0.localizedCaseInsensitiveContains(searchText)
        })
        tableView.reloadData()
    }
}
