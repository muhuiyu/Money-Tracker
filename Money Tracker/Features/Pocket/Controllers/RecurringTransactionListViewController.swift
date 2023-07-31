//
//  RecurringTransactionListViewController.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/4/22.
//

import UIKit

protocol RecurringTransactionListViewControllerDelegate: AnyObject {
    func recurringTransactionListViewControllerDidTapInCell(_ viewController: RecurringTransactionListViewController, _ item: RecurringTransaction)
    func recurringTransactionListViewControllerDidRequestToAddTransaction(_ viewController: RecurringTransactionListViewController, _ item: RecurringTransaction)
    func recurringTransactionListViewControllerDidRequestToDelete(_ viewController: RecurringTransactionListViewController, _ item: RecurringTransaction)
}

class RecurringTransactionListViewController: BaseViewController {

    private let estimatedSpendLabel = UILabel()
    private let tableView = UITableView()

    private var sections = [[RecurringTransaction]](repeating: [RecurringTransaction](), count: 2)
    
    var data: [RecurringTransaction] = [] {
        didSet {
            self.sections[0] = data.filter { $0.isActive }
            self.sections[1] = data.filter { !$0.isActive }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var estimatedSpend: Double = 0 {
        didSet {
            estimatedSpendLabel.text = "Estimated spend: \(estimatedSpend.toCurrencyString()) monthly"
        }
    }
    weak var delegate: RecurringTransactionListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        configureGestures()
        configureBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
// MARK: - View Config
extension RecurringTransactionListViewController {
    private func configureViews() {
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
        
    }
}
// MARK: - Data Source
extension RecurringTransactionListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecurringTransactionCell.reuseID, for: indexPath) as? RecurringTransactionCell else {
            return UITableViewCell()
        }
        cell.viewModel.recurringTransaction.accept(sections[indexPath.section][indexPath.row])
        return cell
    }
}
// MARK: - Delegate
extension RecurringTransactionListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Active"
        case 1: return "Inactive"
        default: return ""
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        delegate?.recurringTransactionListViewControllerDidTapInCell(self, sections[indexPath.section][indexPath.row])
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.delegate?.recurringTransactionListViewControllerDidRequestToDelete(self, self.sections[indexPath.section][indexPath.row])
            self.tableView.isEditing = false
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Add") { _, _, _ in
            self.delegate?.recurringTransactionListViewControllerDidRequestToAddTransaction(self, self.sections[indexPath.section][indexPath.row])
            self.tableView.isEditing = false
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}


