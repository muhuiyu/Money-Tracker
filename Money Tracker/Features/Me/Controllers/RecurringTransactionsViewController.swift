//
//  RecurringTransactionsViewController.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import UIKit
import RxSwift

class RecurringTransactionsViewController: Base.MVVMViewController<RecurringTransactionsViewModel> {

    private let estimatedSpendLabel = UILabel()
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        configureGestures()
        configureBindings()
        
        viewModel.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
// MARK: - View Config
extension RecurringTransactionsViewController {
    private func configureViews() {
        title = "Recurring Transactions"
        
        estimatedSpendLabel.font = UIFont.small
        estimatedSpendLabel.textColor = .secondaryLabel
        estimatedSpendLabel.textAlignment = .left
        view.addSubview(estimatedSpendLabel)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecurringTransactionCell.self, forCellReuseIdentifier: RecurringTransactionCell.reuseID)
        view.addSubview(tableView)
    }
    private func configureConstraints() {
        estimatedSpendLabel.snp.remakeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide).inset(Constants.Spacing.medium)
            make.leading.trailing.equalTo(view.layoutMarginsGuide)
        }
        tableView.snp.remakeConstraints { make in
            make.top.equalTo(estimatedSpendLabel.snp.bottom).offset(Constants.Spacing.small)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func configureGestures() {
        
    }
    private func configureBindings() {
        viewModel.recurringTransactions
            .asObservable()
            .subscribe { [weak self] _ in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                self?.estimatedSpendLabel.text = self?.viewModel.estimatedSpendString
            }
            .disposed(by: disposeBag)
    }
}
// MARK: - Data Source
extension RecurringTransactionsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecurringTransactionCell.reuseID, for: indexPath) as? RecurringTransactionCell else {
            return UITableViewCell()
        }
        if let merchantMap = appCoordinator?.dataProvider.getMerchantsMap() {
            cell.viewModel.merchantList = merchantMap
        }
        cell.viewModel.recurringTransaction.accept(viewModel.sections[indexPath.section][indexPath.row])
        return cell
    }
}
// MARK: - Delegate
extension RecurringTransactionsViewController: UITableViewDelegate {
    enum Section: String {
        case active
        case inactive
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return Section.active.rawValue.capitalizingFirstLetter()
        case 1: return Section.inactive.rawValue.capitalizingFirstLetter()
        default: return ""
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        print("selected", indexPath)
//        delegate?.recurringTransactionListViewControllerDidTapInCell(self, sections[indexPath.section][indexPath.row])
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
//            self.delegate?.recurringTransactionListViewControllerDidRequestToDelete(self, self.sections[indexPath.section][indexPath.row])
            self.tableView.isEditing = false
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Add") { _, _, _ in
//            self.delegate?.recurringTransactionListViewControllerDidRequestToAddTransaction(self, self.sections[indexPath.section][indexPath.row])
            self.tableView.isEditing = false
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}


