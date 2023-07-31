//
//  PendingTransactionListViewController.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/4/22.
//

import UIKit

protocol PendingTransactionListViewControllerDelegate: AnyObject {
    func pendingTransactionListViewControllerDidRequestToDelete(_ viewController: PendingTransactionListViewController, at indexPath: IndexPath)
}

class PendingTransactionListViewController: BaseViewController {
    
    let tableView = UITableView()
    weak var delegate: PendingTransactionListViewControllerDelegate?
    
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
extension PendingTransactionListViewController {
    private func configureViews() {
        tableView.register(TransactionPreviewCell.self, forCellReuseIdentifier: TransactionPreviewCell.reuseID)
        tableView.delegate = self
        view.addSubview(tableView)
    }
    private func configureConstraints() {
        tableView.snp.remakeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func configureGestures() {
        
    }
    private func configureBindings() {
        
    }
}
// MARK: - Delegate
extension PendingTransactionListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.delegate?.pendingTransactionListViewControllerDidRequestToDelete(self, at: indexPath)
            self.tableView.isEditing = false
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}


