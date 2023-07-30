//
//  TransactionFieldOptionListViewController.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/5/22.
//

import Foundation
import UIKit
import RxSwift

class TransactionFieldOptionListViewController: BaseViewController {
    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView = UITableView()
    
    private let viewModel: TransactionViewModel
    private let field: Transaction.EditableField
    private let options: [String]
    private var selectedIndex: Int?
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    private var filteredOptions = [String]()
    
    init(appCoordinator: AppCoordinator? = nil,
         coordinator: BaseCoordinator? = nil,
         viewModel: TransactionViewModel,
         field: Transaction.EditableField) {
        self.viewModel = viewModel
        self.field = field
//        self.options = viewModel.getOptionsData(at: field)
//        self.selectedIndex = viewModel.getSelectedIndex(at: field)
        self.options = []
        self.selectedIndex = 0
        super.init(appCoordinator: appCoordinator, coordinator: coordinator)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        configureViews()
//        configureConstraints()
//        configureGestures()
    }
}
// MARK: - Navigation
//extension TransactionFieldOptionListViewController {
//    @objc
//    private func didTapCancel() {
//        guard let coordinator = coordinator as? HomeCoordinator else { return }
//        coordinator.dismissCurrentModal()
//    }
//}
//// MARK: - View Config
//extension TransactionFieldOptionListViewController {
//    private func configureViews() {
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search"
//        navigationItem.searchController = searchController
//        definesPresentationContext = true
//        navigationItem.setTitle(viewModel.getOptionListTitleString(at: field))
//        navigationItem.setBarButtonItem(at: .left,
//                                        with: Localized.General.cancel,
//                                        isBold: false,
//                                        target: self,
//                                        action: #selector(didTapCancel))
//        tableView.dataSource = self
//        tableView.delegate = self
//        view.addSubview(tableView)
//    }
//    private func configureConstraints() {
//        tableView.snp.remakeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//        }
//    }
//    private func configureGestures() {
//
//    }
//}
//// MARK: - Data Source
//extension TransactionFieldOptionListViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return isFiltering ? filteredOptions.count : options.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let optionList = isFiltering ? filteredOptions : options
//
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
//        switch self.field {
//        case .merchantID:
//            cell.textLabel?.text = Merchant.getMerchantName(of: optionList[indexPath.row])
//        case .categoryID:
//            cell.textLabel?.text = Category.getCategoryName(of: optionList[indexPath.row], isLocalized: true)
//            cell.detailTextLabel?.text = Category.getMainCategoryName(of: optionList[indexPath.row])?.uppercased()
//            cell.detailTextLabel?.textColor = .secondaryLabel
//        default:
//            // TODO: - Add localized
//            cell.textLabel?.text = optionList[indexPath.row]
//        }
//        cell.selectionStyle = .none
//
//        // TODO: - Fix this with filtered content
////        if let selectedIndex = selectedIndex, indexPath.row == selectedIndex {
////            cell.accessoryType = .checkmark
////        }
//        return cell
//    }
//}
//// MARK: - Delegate
//extension TransactionFieldOptionListViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let coordinator = coordinator as? HomeCoordinator else { return }
//
//        defer {
//            tableView.deselectRow(at: indexPath, animated: true)
//        }
//        switch field {
//        case .categoryID, .merchantID:
//            viewModel.updateTransaction(field, to: isFiltering ? self.filteredOptions[indexPath.row] : self.options[indexPath.row])
//        default:
//            guard
//                let cell = tableView.cellForRow(at: indexPath),
//                let value = cell.textLabel?.text
//            else { return }
//            viewModel.updateTransaction(field, to: value)
//        }
//        coordinator.dismissCurrentModal()
//    }
//}
//// MARK: - SearchController
//extension TransactionFieldOptionListViewController: UISearchResultsUpdating, UISearchControllerDelegate {
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let searchText = searchController.searchBar.text else { return }
//        filterOptionForSearchText(searchText)
//    }
//    func filterOptionForSearchText(_ searchText: String) {
//        filteredOptions = options.filter({ text in
//            switch self.field {
//            case .merchantID:
//                guard let merchantName = Merchant.getMerchantName(of: text) else { return false }
//                return merchantName.lowercased().contains(searchText.lowercased())
//            case .categoryID:
//                guard let categoryName = Category.getCategoryName(of: text) else { return false }
//                guard let mainCategoryName = Category.getMainCategoryName(of: text) else { return false }
//                return categoryName.lowercased().contains(searchText.lowercased()) || mainCategoryName.lowercased().contains(searchText.lowercased())
//            default:
//                return text.lowercased().contains(searchText.lowercased())
//            }
//        })
//        tableView.reloadData()
//    }
//}
