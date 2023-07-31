//
//  AnalysisCategoryDetailViewController.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/10/22.
//

import UIKit
import RxSwift

class AnalysisCategoryDetailViewController: BaseViewController {
    private let disposeBag = DisposeBag()
    
    // MARK: - View
    private let headerView = AnalysisCategoryDetailHeaderView()
    private let tableView = UITableView()
    
    private var sections = [TransactionSection]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var transacitons: TransactionList = [] {
        didSet {
//            configureCells()
//            configureHeaderView()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        configureViews()
//        configureConstraints()
//        configureSignals()
    }
}
// MARK: - TapHandlers
extension AnalysisCategoryDetailViewController {
    
}
// MARK: - View Config
//extension AnalysisCategoryDetailViewController {
//    private func configureHeaderView() {
//        guard
//            let mainCategoryID = transacitons[0].mainCategoryID,
//            let mainCategoryName = MainCategory.getName(of: mainCategoryID) else {
//            return
//        }
//        headerView.title = mainCategoryName
//        headerView.displayTotalAmountString = self.transacitons.totalAmount.toCurrencyString()
//    }
//    /// Groups transactions by category
//    private func configureCells() {
//        self.sections.removeAll()
//        let groupedTransactions = transacitons.groupedByCategory()
//        for entry in groupedTransactions {
//            guard let categoryName = Category.getCategoryName(of: entry.key) else { continue }
//            self.sections.append(TransactionSection(header: categoryName,
//                                                    items: entry.value.sorted { $0.date < $1.date }))
//        }
//    }
//    private func configureViews() {
//        view.addSubview(headerView)
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(TransactionPreviewCell.self, forCellReuseIdentifier: TransactionPreviewCell.reuseID)
//        view.addSubview(tableView)
//
//        view.layer.cornerRadius = 20
//    }
//    private func configureConstraints() {
//        headerView.snp.remakeConstraints { make in
//            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
//        }
//        tableView.snp.remakeConstraints { make in
//            make.top.equalTo(headerView.snp.bottom)
//            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
//        }
//    }
//    private func configureSignals() {
//
//    }
//}
//// MARK: - Data Source
//extension AnalysisCategoryDetailViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return sections.count
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return sections[section].items.count
//    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sections[section].header
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionPreviewCell.reuseID, for: indexPath) as? TransactionPreviewCell else { return UITableViewCell() }
//        cell.viewModel.subtitleAttribute = .date
//        cell.viewModel.transaction.accept(sections[indexPath.section].items[indexPath.row])
//        return cell
//    }
//}
//// MARK: - Delegate
//extension AnalysisCategoryDetailViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        defer {
//            tableView.deselectRow(at: indexPath, animated: true)
//        }
//        guard let coordinator = coordinator as? HomeCoordinator else { return }
//        coordinator.showTransactionDetail(sections[indexPath.section].items[indexPath.row].id)
//    }
//}
//
//
