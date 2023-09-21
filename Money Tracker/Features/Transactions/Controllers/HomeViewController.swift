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
    private let appNavigationBar = AppNavigationBar(contentType: .wallets)
    private let headerView = UIView()
    private let monthControlView = MonthControlHeaderView()
    private let homeSummaryView = HomeSummaryView()
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let refreshControl = UIRefreshControl()
    private let quickAddButton = HomeQuickAddButton()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        configureBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.reloadTransactions()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

// MARK: - TapHandlers
extension HomeViewController {
    func didTapSearch() {
        guard let coordinator = coordinator as? HomeCoordinator else { return }
        coordinator.showSearch()
    }
    func didTapWallets() {
        guard let coordinator = coordinator as? HomeCoordinator else { return }
        coordinator.showChooseWallet()
    }
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
    private func didTapQuickAdd() {
        guard let coordinator = coordinator as? HomeCoordinator else { return }
        coordinator.showQuickAdd(from: self)
    }
}
// MARK: - View Config
extension HomeViewController {
    private func configureViews() {
        // NavigationBar
        appNavigationBar.tapWalletsHandler = { [weak self] in
            self?.didTapWallets()
        }
        appNavigationBar.tapSearchHandler = { [weak self] in
            self?.didTapSearch()
        }
        view.addSubview(appNavigationBar)
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
        
        // Set up tableView
        let headerView = UIView()
        headerView.snp.remakeConstraints { make in
            make.height.equalTo(12)
        }
        tableView.tableHeaderView = headerView
        tableView.refreshControl = refreshControl
        tableView.backgroundColor = UIColor.systemGroupedBackground
        tableView.register(ListStyleTableViewCell.self, forCellReuseIdentifier: ListStyleTableViewCell.reuseID)
        tableView.register(TransactionPreviewCell.self, forCellReuseIdentifier: TransactionPreviewCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        quickAddButton.tapHandler = { [weak self] in
            self?.didTapQuickAdd()
        }
        view.addSubview(quickAddButton)
    }
    private func configureConstraints() {
        appNavigationBar.snp.remakeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        monthControlView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        homeSummaryView.snp.remakeConstraints { make in
            make.top.equalTo(monthControlView.snp.bottom).offset(Constants.Spacing.medium)
            make.leading.trailing.equalTo(monthControlView)
            make.bottom.equalToSuperview()
        }
        headerView.snp.remakeConstraints { make in
            make.top.equalTo(appNavigationBar.snp.bottom).offset(Constants.Spacing.large)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.snp.remakeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        quickAddButton.snp.remakeConstraints { make in
            make.trailing.bottom.equalTo(view.layoutMarginsGuide).inset(Constants.Spacing.medium)
        }
    }
    private func configureBindings() {
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
            .subscribe { [weak self] _ in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.currentYearMonth
            .bind(to: monthControlView.yearMonth)
            .disposed(by: disposeBag)
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
// MARK: - DataSource
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.displayTransactions.value.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.displayTransactions.value[section].items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionPreviewCell.reuseID, for: indexPath) as? TransactionPreviewCell else {
            return UITableViewCell()
        }
        if let dataProvider = appCoordinator?.dataProvider {
            cell.viewModel.merchantList = dataProvider.getMerchantsMap()
        }
        cell.viewModel.subtitleAttribute = .category
        cell.viewModel.transaction.accept(viewModel.getTransaction(at: indexPath))
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ListStyleTableViewHeader()
        view.text = viewModel.displayTransactions.value[section].header
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32.0
    }
}
// MARK: - Delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        guard let coordinator = coordinator as? HomeCoordinator, let transaction = viewModel.getTransaction(at: indexPath) else { return }
        coordinator.showTransactionDetail(transaction.id)
    }
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

// MARK: - Delegate
extension HomeViewController: QuickAddViewControllerDelegate {
    func quickAddViewControllerDidSelect(_ item: TransactionSettings) {
        let transaction = Transaction(from: item)
        guard let coordinator = coordinator as? HomeCoordinator else { return }
        coordinator.dismissCurrentModal {
            coordinator.showAddTransaction(copyFrom: transaction)
        }
    }
}
