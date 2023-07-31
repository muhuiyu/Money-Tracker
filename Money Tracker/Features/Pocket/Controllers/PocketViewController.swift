//
//  PocketViewController.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/3/22.
//

import UIKit
import RxSwift

class PocketViewController: BaseViewController {
    private let disposeBag = DisposeBag()
    
    private let segmentedControl = UISegmentedControl(items: ["Scheduled", "Recurring"])
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    private let pendingTransactionListViewController = PendingTransactionListViewController()
    private let recurringTransactionListViewController = RecurringTransactionListViewController()
    
    private let tableView = UITableView()
    var pocketViewModel = PocketViewModel()
    var transactionListViewModel = TransactionListViewModel()
//    let reloadOption: TransactionListViewModel.ReloadTransactionsOption = .pendingOnly
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        configureViews()
//        configureConstraints()
//        configureGestures()
//        configureBindings()
//
//        transactionListViewModel.reloadTransactions(reloadOption, shouldPull: true)
//        pocketViewModel.reloadRecurringTransactions(shouldPull: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        transactionListViewModel.reloadTransactions(reloadOption)
//        pocketViewModel.reloadRecurringTransactions()
    }
}
// MARK: - Handlers
//extension PocketViewController {
//    @objc
//    private func didTapAdd() {
//
//    }
//    @objc
//    private func didChangeValue(_ sender: UISegmentedControl) {
//        switch sender.selectedSegmentIndex {
//        case 0:
//            pageViewController.setViewControllers([pendingTransactionListViewController], direction: .reverse, animated: false)
//        case 1:
//            pageViewController.setViewControllers([recurringTransactionListViewController], direction: .forward, animated: false)
//        default:
//            return
//        }
//    }
//}
//// MARK: - View Config
//extension PocketViewController {
//    private func configureViews() {
//        title = pocketViewModel.displayTitle
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Icons.plus),
//                                                            style: .plain,
//                                                            target: self,
//                                                            action: #selector(didTapAdd))
//        segmentedControl.selectedSegmentIndex = 0
//        segmentedControl.addTarget(self, action: #selector(didChangeValue(_:)), for: .valueChanged)
//        view.addSubview(segmentedControl)
//
//        pendingTransactionListViewController.delegate = self
//        recurringTransactionListViewController.delegate = self
//        pageViewController.setViewControllers([pendingTransactionListViewController], direction: .reverse, animated: false)
//        addChild(pageViewController)
//        view.addSubview(pageViewController.view)
//    }
//    private func configureConstraints() {
//        segmentedControl.snp.remakeConstraints { make in
//            make.top.equalTo(view.layoutMarginsGuide)
//            make.centerX.equalToSuperview()
//        }
//        pageViewController.view.snp.remakeConstraints { make in
//            make.top.equalTo(segmentedControl.snp.bottom).offset(Constants.Spacing.small)
//            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
//        }
//    }
//    private func configureGestures() {
//
//    }
//    private func configureBindings() {
//        guard let coordinator = coordinator as? HomeCoordinator else { return }
//
//        transactionListViewModel.displayTransactions
//            .bind(to: pendingTransactionListViewController.tableView.rx.items(dataSource: transactionListViewModel.transactionDataSource))
//            .disposed(by: disposeBag)
//
//        Observable
//            .zip(pendingTransactionListViewController.tableView.rx.itemSelected, pendingTransactionListViewController.tableView.rx.modelSelected(Transaction.self))
//            .subscribe { indexPath, item in
//                coordinator.showTransactionDetail(item.id)
//                self.tableView.deselectRow(at: indexPath, animated: true)
//            }
//            .disposed(by: disposeBag)
//
//        pocketViewModel.recurringTransactions
//            .asObservable()
//            .subscribe(onNext: { value in
//                // TODO: - Add estimated spending
//                self.recurringTransactionListViewController.estimatedSpend = 123
//                self.recurringTransactionListViewController.data = value
//            })
//            .disposed(by: disposeBag)
//    }
//}
//// MARK: - Delegate from PendingTransactionListViewController
//extension PocketViewController: PendingTransactionListViewControllerDelegate {
//    func pendingTransactionListViewControllerDidRequestToDelete(_ viewController: PendingTransactionListViewController, at indexPath: IndexPath) {
//        guard let coordinator = coordinator as? HomeCoordinator else { return }
//        let alertOption = BaseCoordinator.AlertControllerOption(title: "Delete transaction?",
//                                                                message: "The transaction will be permanently deleted from the database.",
//                                                                preferredStyle: .alert)
//
//        let deleteAction = BaseCoordinator.AlertActionOption(title: "Delete", style: .destructive) { _ in
//            self.transactionListViewModel.deleteTransaction(at: indexPath) {
//                DispatchQueue.main.async {
//                    self.pendingTransactionListViewController.tableView.reloadData()
//                    self.pendingTransactionListViewController.tableView.isEditing = false
//                }
//            }
//        }
//        let cancelAction = BaseCoordinator.AlertActionOption(title: "Cancel", style: .cancel) { _ in
//            self.pendingTransactionListViewController.tableView.isEditing = false
//        }
//        coordinator.presentAlert(option: alertOption, actions: [cancelAction, deleteAction])
//
//    }
//}
//// MARK: - Delegate from RecurringTransactionListViewController
//extension PocketViewController: RecurringTransactionListViewControllerDelegate {
//    func recurringTransactionListViewControllerDidTapInCell(_ viewController: RecurringTransactionListViewController, _ item: RecurringTransaction) {
//        guard let coordinator = coordinator as? HomeCoordinator else { return }
//        coordinator.showRecurringTransactionDetail(item.id)
//    }
//    func recurringTransactionListViewControllerDidRequestToDelete(_ viewController: RecurringTransactionListViewController, _ item: RecurringTransaction) {
//        pocketViewModel.deleteRecurringTransaction(item)
//    }
//    func recurringTransactionListViewControllerDidRequestToAddTransaction(_ viewController: RecurringTransactionListViewController, _ item: RecurringTransaction) {
//        guard let coordinator = coordinator as? HomeCoordinator else { return }
//        let transaction = Transaction(from: item)
//        coordinator.showAddTransaction(copyFrom: transaction)
//    }
//}
//
