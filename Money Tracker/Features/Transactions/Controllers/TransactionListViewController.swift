//
//  TransactionListViewController.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import UIKit
import RxSwift

class TransactionListViewController: BaseViewController {
    private let disposeBag = DisposeBag()
    
    private let tableView = UITableView()
    var transactionListViewModel = TransactionListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        configureViews()
//        configureConstraints()
//        configureGestures()
//        configureSignals()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
// MARK: - View Config
//extension TransactionListViewController {
//    private func configureViews() {
//        tableView.register(TransactionPreviewCell.self, forCellReuseIdentifier: TransactionPreviewCell.reuseID)
//        view.addSubview(tableView)
//    }
//    private func configureConstraints() {
//        tableView.snp.remakeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide)
//            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
//        }
//    }
//    private func configureGestures() {
//
//    }
//    private func configureSignals() {
//        guard let coordinator = coordinator as? HomeCoordinator else { return }
//
//        transactionListViewModel.displayTransactions
//            .bind(to: tableView.rx.items(dataSource: transactionListViewModel.transactionDataSource))
//            .disposed(by: disposeBag)
//
//        Observable
//            .zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Transaction.self))
//            .subscribe { indexPath, item in
//                coordinator.showTransactionDetail(item.id)
//                self.tableView.deselectRow(at: indexPath, animated: true)
//            }
//            .disposed(by: disposeBag)
//    }
//}
