//
//  BudgetListViewController.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/30/23.
//

import UIKit
import RxSwift
import RxRelay
import RxDataSources

class BudgetListViewController: Base.MVVMViewController<BudgetListViewModel> {
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.reloadBudgets { _ in
            self.configureViews()
            self.configureConstraints()
            self.configureBindings()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.reloadBudgets { _ in
            
        }
    }
}
// MARK: - Actions
extension BudgetListViewController {
    @objc
    func didPullToRefresh(_ sender: UIRefreshControl) {
        refreshControl.beginRefreshing()
        viewModel.reloadBudgets { _ in
            self.refreshControl.endRefreshing()
        }
    }
    @objc
    private func didTapEditBudgets() {
        guard let coordinator = coordinator as? BudgetCoordinator else { return }
        coordinator.showEditBudgets()
    }
}
// MARK: - View Config
extension BudgetListViewController {
    private func configureViews() {
        title = viewModel.displayTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                            target: self,
                                                            action: #selector(didTapEditBudgets))

        refreshControl.addTarget(self,
                                 action: #selector(didPullToRefresh(_:)),
                                 for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.register(BudgetCell.self, forCellReuseIdentifier: BudgetCell.reuseID)
        tableView.register(TitleValueCell.self, forCellReuseIdentifier: TitleValueCell.reuseID)
        tableView.register(BudgetSummaryCell.self, forCellReuseIdentifier: BudgetSummaryCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    private func configureConstraints() {
        tableView.snp.remakeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func configureBindings() {
        viewModel.cells
            .asObservable()
            .subscribe(onNext: { _ in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
            .disposed(by: disposeBag)
    }
}
// MARK: - DataSource
extension BudgetListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.cells.value.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cells.value[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cells.value[indexPath.section][indexPath.row]
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitles[section]
    }
}
// MARK: - Delegate
extension BudgetListViewController: UITableViewDelegate {
    enum Section: Int, CaseIterable {
        case header = 0
        case list
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }

        guard let coordinator = coordinator as? BudgetCoordinator else { return }

        switch indexPath.section {
        case Section.header.rawValue:
            // Upcoming payments section
            if indexPath.row == 1 {
                coordinator.showPocket()
            }
            return
        case Section.list.rawValue:
            guard let itemID = viewModel.getBudgetItemID(at: indexPath) else { return }
            coordinator.showBudgetDetail(itemID)
        default:
            return
        }
    }
}
