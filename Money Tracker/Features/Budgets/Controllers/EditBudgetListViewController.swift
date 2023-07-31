//
//  EditBudgetListViewController.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/4/22.
//

import UIKit
import RxSwift

class EditBudgetListViewController: Base.MVVMViewController<EditBudgetListViewModel> {
    
    // MARK: - Views
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.reloadBudgets { _ in
            self.configureViews()
            self.configureConstraints()
            self.configureGestures()
        }
    }
}
// MARK: - Actions
extension EditBudgetListViewController {
    @objc
    private func didTapInView() {
        view.endEditing(true)
    }
    @objc
    private func didTapCancel() {
        coordinator?.dismissCurrentModal()
    }
    @objc
    private func didTapSave() {
        viewModel.updateBudgets()
        coordinator?.dismissCurrentModal()
    }
}
// MARK: - View Config
extension EditBudgetListViewController {
    private func configureViews() {
        // MARK: - Navigation Bar
        navigationItem.setTitle(Localized.Budget.editBudgetTitle)
        navigationItem.setBarButtonItem(at: .left,
                                        with: Localized.General.cancel,
                                        isBold: false,
                                        target: self,
                                        action: #selector(didTapCancel))
        navigationItem.setBarButtonItem(at: .right,
                                        with: Localized.General.save,
                                        isBold: true,
                                        target: self,
                                        action: #selector(didTapSave))
        
        // MARK: - TableView
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
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
}
// MARK: - TableViewDataSource
extension EditBudgetListViewController: UITableViewDataSource {
    enum Section: Int, CaseIterable {
        case header = 0
        case list
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Section.header.rawValue:
            return 1
        case Section.list.rawValue:
            return viewModel.editingBudgets.value.count
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Section.header.rawValue:
            return UITableViewCell()
        case Section.list.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BudgetEditCell.reuseID, for: indexPath) as? BudgetEditCell else { return UITableViewCell() }
            
//            cell.viewModel.budget.accept(viewModel.getBudgetItem(at: indexPath))
            
            let budget = viewModel.getBudgetItem(at: indexPath)
            cell.budget = budget
            cell.value = budget?.amount ?? 0
            cell.changeBudgetAmountHandler = {
                self.viewModel.updateEditingBudget(to: cell.value, at: indexPath)
            }
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}
// MARK: - TableViewDelegate
extension EditBudgetListViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

