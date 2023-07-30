//
//  HomeViewController.swift
//  Why am I so poor
//
//  Created by Mu Yu on 6/25/22.
//

import UIKit
import RxSwift

class HomeViewController: Base.MVVMViewController<HomeViewModel> {
    
    // MARK: - View
    private let headerView = UIView()
    private let balanceView = HomeHeaderView()
    private let listHeaderView = TransactionListHeaderView()
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    
    // MARK: - View Models
//    let reloadOption: HomeViewModel.ReloadTransactionsOption = .inRecentThirtyDays
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        configureViews()
//        configureConstraints()
//        configureSignals()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        viewModel.reloadTransactions(reloadOption, shouldPull: true) { result in
//            self.handleError(of: result)
//        }
    }
}
// MARK: - TapHandlers
//extension HomeViewController {
//    @objc
//    func didTapOnNotification(_ sender: UIBarButtonItem) {
//        guard let coordinator = coordinator as? HomeCoordinator else { return }
//        coordinator.showNotifications()
//    }
//    @objc
//    func didPullToRefresh(_ sender: UIRefreshControl) {
//        refreshControl.beginRefreshing()
//        viewModel.reloadTransactions(reloadOption, shouldPull: true) { _ in
//            self.refreshControl.endRefreshing()
//        }
//    }
//    private func didTapAddTransaction() {
//        guard let coordinator = coordinator as? HomeCoordinator else { return }
//        coordinator.presentAlert(option: BaseCoordinator.AlertControllerOption(title: "Add transaction",
//                                                                               message: nil,
//                                                                               preferredStyle: .actionSheet),
//                                      actions: [
//                                        BaseCoordinator.AlertActionOption(title: "Add grocery", style: .default) { _ in
//                                            coordinator.showAddTransaction(copyFrom: Transaction.defaultGroceryTransaction)
//                                        },
//                                        BaseCoordinator.AlertActionOption(title: "Add Transport", style: .default) { _ in
//                                            coordinator.showAddTransaction(copyFrom: Transaction.defaultTransportTransaction)
//                                        },
//                                        BaseCoordinator.AlertActionOption(title: "Cancel", style: .cancel, handler: nil)
//                                      ])
//    }
//    private func didTapPocket() {
//        guard let coordinator = coordinator as? HomeCoordinator else { return }
//        coordinator.showPocket()
//    }
//    private func didTapBalanceView() {
//        guard let coordinator = coordinator as? HomeCoordinator else { return }
//        coordinator.showMonthlyAnalysis()
//    }
//}
//// MARK: - View Config
//extension HomeViewController {
//    private func configureViews() {
//        guard let coordinator = coordinator as? HomeCoordinator else { return }
//
//        title = viewModel.displayTitle
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Icons.bellbadgeFill),
//                                                            style: .plain,
//                                                            target: self,
//                                                            action: #selector(didTapOnNotification(_ :)))
//
//        balanceView.addTransactionTapHandler = { [weak self] in
//            self?.didTapAddTransaction()
//        }
//        balanceView.pocketTaphandler = { [weak self] in
//            self?.didTapPocket()
//        }
//        balanceView.analysisViewTapHandler = { [weak self] in
//            self?.didTapBalanceView()
//        }
//        headerView.addSubview(balanceView)
//
//        listHeaderView.tapHandler = {
//            coordinator.showTransactionList()
//        }
//        headerView.addSubview(listHeaderView)
//        view.addSubview(headerView)
//
//        // TODO: - Set as headerView
////        tableView.tableHeaderView = headerView
////        tableView.tableHeaderView?.layoutIfNeeded()
////        tableView.tableHeaderView = tableView.tableHeaderView
//
//        refreshControl.attributedTitle = NSAttributedString(string: viewModel.displayRefreshControlString)
//        refreshControl.addTarget(self,
//                                 action: #selector(didPullToRefresh(_:)),
//                                 for: .valueChanged)
//        tableView.refreshControl = refreshControl
//        tableView.register(TransactionPreviewCell.self, forCellReuseIdentifier: TransactionPreviewCell.reuseID)
//        tableView.delegate = self
//        view.addSubview(tableView)
//    }
//    private func configureConstraints() {
//        balanceView.snp.remakeConstraints { make in
//            make.top.equalTo(view.layoutMarginsGuide).inset(Constants.Spacing.medium)
//            make.leading.trailing.equalToSuperview()
//        }
//        listHeaderView.snp.remakeConstraints { make in
//            make.top.equalTo(balanceView.snp.bottom).offset(Constants.Spacing.medium)
//            make.leading.trailing.equalTo(balanceView)
//            make.bottom.equalToSuperview()
//        }
//        headerView.snp.remakeConstraints { make in
//            make.top.leading.trailing.equalTo(view.layoutMarginsGuide)
//        }
//        tableView.snp.remakeConstraints { make in
//            make.top.equalTo(headerView.snp.bottom)
//            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
//        }
//    }
//    private func configureSignals() {
//        guard let coordinator = coordinator as? HomeCoordinator else { return }
//
//        viewModel.displayTransactions
//            .asObservable()
//            .bind(to: tableView.rx.items(dataSource: viewModel.transactionDataSource))
//            .disposed(by: disposeBag)
//
//        Observable
//            .zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Transaction.self))
//            .subscribe { indexPath, item in
//                coordinator.showTransactionDetail(item.id)
//                self.tableView.deselectRow(at: indexPath, animated: true)
//            }
//            .disposed(by: disposeBag)
//
//        viewModel.displayMonthlyBalanceString
//            .asObservable()
//            .subscribe { value in
//                self.balanceView.amountString = value
//            }
//            .disposed(by: disposeBag)
//
//        viewModel.displayNumberOfAccountsString
//            .asObservable()
//            .subscribe { value in
//                self.balanceView.subtitleString = value
//            }
//            .disposed(by: disposeBag)
//
//    }
//
//    private func handleError(of result: VoidResult) {
//        switch result {
//        case .success:
//            return
//        case .failure(let error):
//            let alert = ErrorHandler.shared.createAlert(for: error)
//            present(alert, animated: true)
//        }
//    }
//}
//// MARK: - Delegate
//extension HomeViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        guard let coordinator = coordinator as? HomeCoordinator else { return nil }
//
//        let alertOption = BaseCoordinator.AlertControllerOption(title: Text.deleteTransactionConfirmationAlertTitle,
//                                                                message: Text.deleteTransactionConfirmationAlertContent,
//                                                                preferredStyle: .alert)
//        let deleteAction = BaseCoordinator.AlertActionOption(title: Text.delete, style: .destructive) { _ in
//            self.viewModel.deleteTransaction(at: indexPath)
//            self.tableView.isEditing = false
//        }
//        let cancelAction = BaseCoordinator.AlertActionOption(title: Text.cancel, style: .cancel) { _ in
//            self.tableView.isEditing = false
//        }
//        let action = UIContextualAction(style: .destructive, title: Text.delete) { _, _, _ in
//            coordinator.presentAlert(option: alertOption, actions: [cancelAction, deleteAction])
//        }
//        return UISwipeActionsConfiguration(actions: [action])
//    }
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        guard let coordinator = coordinator as? HomeCoordinator else { return nil }
//
//        let action = UIContextualAction(style: .normal, title: Text.duplicate) { _, _, _ in
//            let transaction = self.viewModel.getTransaction(at: indexPath)
//            coordinator.showAddTransaction(copyFrom: transaction)
//            self.tableView.isEditing = false
//        }
//        return UISwipeActionsConfiguration(actions: [action])
//    }
//}
//
