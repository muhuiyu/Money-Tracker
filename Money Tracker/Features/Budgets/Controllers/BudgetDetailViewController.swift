//
//  BudgetDetailViewController.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/4/22.
//

import UIKit
import RxSwift

class BudgetDetailViewController: Base.MVVMViewController<BudgetViewModel> {

    // MARK: - Views
    private let headerView = DetailHeaderView()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        configureGestures()
        configureBindings()
    }
}
// MARK: - View Config
extension BudgetDetailViewController {
    private func configureViews() {
        view.addSubview(headerView)
        tableView.register(TransactionPreviewCell.self, forCellReuseIdentifier: TransactionPreviewCell.reuseID)
        view.addSubview(tableView)
    }
    private func configureConstraints() {
        headerView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalTo(view.layoutMarginsGuide)
        }
        tableView.snp.remakeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(Constants.Spacing.large)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func configureGestures() {
        
    }
    private func configureBindings() {
        guard let coordinator = coordinator as? BudgetCoordinator else { return }
        
        viewModel.displayTransactions
            .asObservable()
            .subscribe { [weak self] _ in
                self?.configureData()
            }
            .disposed(by: disposeBag)
        
        viewModel.displayTransactions
            .asObservable()
            .bind(to: tableView.rx.items(dataSource: viewModel.transactionDataSource))
            .disposed(by: disposeBag)

        Observable
            .zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Transaction.self))
            .subscribe { indexPath, item in
                coordinator.showTransactionDetail(item.id)
                self.tableView.deselectRow(at: indexPath, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureData() {
        headerView.title = viewModel.displayRemainingAmountString
        headerView.firstSubtitle = viewModel.displayCategoryString
        headerView.secondSubtitle = viewModel.displayMonthlyAverageString
    }
}
