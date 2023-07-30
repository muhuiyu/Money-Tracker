//
//  EditBudgetViewController.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/4/22.
//

import UIKit
import RxSwift

class EditBudgetViewController: BaseViewController {
    private let disposeBag = DisposeBag()
    
    var viewModel = BudgetListViewModel()
    
    // MARK: - Views
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        configureGestures()
        configureSignals()
    }
}
// MARK: - Actions
extension EditBudgetViewController {
    @objc
    private func didTapInView() {
        view.endEditing(true)
    }
    @objc
    private func didTapSave() {
        
    }
}
// MARK: - View Config
extension EditBudgetViewController {
    private func configureViews() {
        // MARK: - Navigation Bar
        navigationItem.setTitle(Localized.Budget.editBudgetTitle)
        navigationItem.setBarButtonItem(at: .right,
                                        with: Localized.General.save,
                                        isBold: true,
                                        target: self,
                                        action: #selector(didTapSave))
        
        // MARK: - TableView
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.register(BudgetEditCell.self, forCellReuseIdentifier: BudgetEditCell.reuseID)
        view.addSubview(tableView)
        
        // TODO: - Allow to set budget for items (subcategory)
    }
    private func configureConstraints() {
        tableView.snp.remakeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func configureGestures() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapInView))
        view.addGestureRecognizer(tapRecognizer)
    }
    private func configureSignals() {
//        viewModel.displayBudgets
//            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource))
//            .disposed(by: disposeBag)
    }
}
// MARK: - TableView Delegate
extension EditBudgetViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

