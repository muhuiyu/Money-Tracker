//
//  BudgetDetailViewController.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/4/22.
//

import UIKit
import RxSwift

class BudgetDetailViewController: BaseViewController {
    private let disposeBag = DisposeBag()
    
    // MARK: - Views
    private let headerView = DetailHeaderView()
    private let tableView = UITableView()
    
    var viewModel = BudgetViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        configureGestures()
        configureSignals()
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
    private func configureSignals() {
        viewModel.displayRemainingAmountString
            .asObservable()
            .subscribe { value in
                self.headerView.title = value
            }
            .disposed(by: disposeBag)

        viewModel.displayCategoryString
            .asObservable()
            .subscribe { value in
                self.headerView.firstSubtitle = value
            }
            .disposed(by: disposeBag)
        
        viewModel.displayMonthlyAverageString
            .asObservable()
            .subscribe { value in
                self.headerView.secondSubtitle = value
            }
            .disposed(by: disposeBag)
        
        viewModel.displayTransactions
            .asObservable()
            .bind(to: tableView.rx.items(dataSource: viewModel.transactionDataSource))
            .disposed(by: disposeBag)
        
        Observable
            .zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Transaction.self))
            .subscribe { indexPath, item in
                // TODO: - 
                print("will do")
//                self.homeCoordinator?.showTransactionDetail(item.id)
                self.tableView.deselectRow(at: indexPath, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
