//
//  HomeViewController.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/30/23.
//

import UIKit
import RxSwift

class HomeViewController: Base.MVVMViewController<HomeViewModel> {
    
    // MARK: - View
    private let headerView = UIView()
    private let balanceView = HomeHeaderView()
    private let monthControlView = MonthControlHeaderView()
    private let homeSummaryView = HomeSummaryView()
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        configureBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.reloadTransactions()
    }
}

// MARK: - TapHandlers
extension HomeViewController {
    @objc
    func didTapOnNotification(_ sender: UIBarButtonItem) {
        guard let coordinator = coordinator as? HomeCoordinator else { return }
        coordinator.showNotifications()
    }
    @objc
    func didPullToRefresh(_ sender: UIRefreshControl) {
        refreshControl.beginRefreshing()
        viewModel.reloadTransactions() { _ in
            self.refreshControl.endRefreshing()
        }
    }
    @objc
    private func didTapAddTransaction() {
        guard let coordinator = coordinator as? HomeCoordinator else { return }
        coordinator.presentAlert(option: BaseCoordinator.AlertControllerOption(title: "Add transaction",
                                                                               message: nil,
                                                                               preferredStyle: .actionSheet),
                                      actions: [
                                        BaseCoordinator.AlertActionOption(title: "Add grocery", style: .default) { _ in
                                            coordinator.showAddTransaction(copyFrom: Transaction.defaultGroceryTransaction)
                                        },
                                        BaseCoordinator.AlertActionOption(title: "Add Transport", style: .default) { _ in
                                            coordinator.showAddTransaction(copyFrom: Transaction.defaultTransportTransaction)
                                        },
                                        BaseCoordinator.AlertActionOption(title: "Cancel", style: .cancel, handler: nil)
                                      ])
    }
}
// MARK: - View Config
extension HomeViewController {
    private func configureViews() {
        guard let coordinator = coordinator as? HomeCoordinator else { return }

        title = viewModel.displayTitle
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: Icons.plus),
                            style: .plain,
                            target: self,
                            action: #selector(didTapAddTransaction)),
            UIBarButtonItem(image: UIImage(systemName: Icons.bellbadgeFill),
                            style: .plain,
                            target: self,
                            action: #selector(didTapOnNotification(_ :)))
        ]
        
        view.backgroundColor = .systemBackground

        monthControlView.previousButtonTapHandler = { [weak self] in
            if let previousMonth = self?.viewModel.currentYearMonth.value.previousMonth {
                self?.viewModel.currentYearMonth.accept(previousMonth)
            }
        }
        
        monthControlView.nextButtonTapHandler = { [weak self] in
            if let nextMonth = self?.viewModel.currentYearMonth.value.nextMonth {
                self?.viewModel.currentYearMonth.accept(nextMonth)
            }
        }
        
        headerView.addSubview(monthControlView)
        headerView.addSubview(homeSummaryView)
        view.addSubview(headerView)

        refreshControl.attributedTitle = NSAttributedString(string: viewModel.displayRefreshControlString)
        refreshControl.addTarget(self,
                                 action: #selector(didPullToRefresh(_:)),
                                 for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.register(TransactionPreviewCell.self, forCellReuseIdentifier: TransactionPreviewCell.reuseID)
        tableView.delegate = self
        view.addSubview(tableView)
    }
    private func configureConstraints() {
        monthControlView.snp.remakeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide).inset(Constants.Spacing.medium)
            make.leading.trailing.equalToSuperview()
        }
        homeSummaryView.snp.remakeConstraints { make in
            make.top.equalTo(monthControlView.snp.bottom).offset(Constants.Spacing.medium)
            make.leading.trailing.equalTo(monthControlView)
            make.bottom.equalToSuperview()
        }
        headerView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalTo(view.layoutMarginsGuide)
        }
        tableView.snp.remakeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func configureBindings() {
        guard let coordinator = coordinator as? HomeCoordinator else { return }
        
        viewModel.income
            .asObservable()
            .bind(to: homeSummaryView.income)
            .disposed(by: disposeBag)
        
        viewModel.expense
            .asObservable()
            .bind(to: homeSummaryView.expense)
            .disposed(by: disposeBag)

        viewModel.displayTransactions
            .asObservable()
            .bind(to: tableView.rx.items(dataSource: viewModel.transactionDataSource))
            .disposed(by: disposeBag)
        
        viewModel.currentYearMonth
            .bind(to: monthControlView.yearMonth)
            .disposed(by: disposeBag)

        Observable
            .zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Transaction.self))
            .subscribe { indexPath, item in
                coordinator.showTransactionDetail(item.id)
                self.tableView.deselectRow(at: indexPath, animated: true)
            }
            .disposed(by: disposeBag)

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

    }

    private func handleError(of result: VoidResult) {
        switch result {
        case .success:
            return
        case .failure(let error):
            let alert = ErrorHandler.shared.createAlert(for: error)
            present(alert, animated: true)
        }
    }
}
// MARK: - Delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let coordinator = coordinator as? HomeCoordinator else { return nil }

        let alertOption = BaseCoordinator.AlertControllerOption(title: Text.deleteTransactionConfirmationAlertTitle,
                                                                message: Text.deleteTransactionConfirmationAlertContent,
                                                                preferredStyle: .alert)
        let deleteAction = BaseCoordinator.AlertActionOption(title: Text.delete, style: .destructive) { _ in
            self.viewModel.deleteTransaction(at: indexPath)
            self.tableView.isEditing = false
        }
        let cancelAction = BaseCoordinator.AlertActionOption(title: Text.cancel, style: .cancel) { _ in
            self.tableView.isEditing = false
        }
        let action = UIContextualAction(style: .destructive, title: Text.delete) { _, _, _ in
            coordinator.presentAlert(option: alertOption, actions: [cancelAction, deleteAction])
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let coordinator = coordinator as? HomeCoordinator else { return nil }

        let action = UIContextualAction(style: .normal, title: Text.duplicate) { _, _, _ in
            let transaction = self.viewModel.getTransaction(at: indexPath)
            coordinator.showAddTransaction(copyFrom: transaction)
            self.tableView.isEditing = false
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}

//private func didTapPocket() {
//        guard let coordinator = coordinator as? HomeCoordinator else { return }
//        coordinator.showPocket()
//}
//private func didTapBalanceView() {
//        guard let coordinator = coordinator as? HomeCoordinator else { return }
//        coordinator.showMonthlyAnalysis()
//}
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
