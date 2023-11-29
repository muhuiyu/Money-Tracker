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
    
    // MARK: - Views
    private let appNavigationBar = AppNavigationBar(contentType: .title("Budget"))
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.reloadBudgets { _ in
            self.configureViews()
            self.configureConstraints()
            self.configureBindings()
        }
        configureNotificationObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        viewModel.reloadBudgets { _ in
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
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
    func didTapSearch() {
        guard let coordinator = coordinator as? BudgetCoordinator else { return }
        coordinator.showSearch()
    }
}
// MARK: - View Config
extension BudgetListViewController {
    private func configureViews() {
        appNavigationBar.tapSearchHandler = { [weak self] in
            self?.didTapSearch()
        }
        view.addSubview(appNavigationBar)

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
        appNavigationBar.snp.remakeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.snp.remakeConstraints { make in
            make.top.equalTo(appNavigationBar.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
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
    private func configureNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name.reloadBudgets, object: nil)
    }
    @objc
    private func reloadData() {
        viewModel.reloadBudgets { _ in
            
        }
    }
}
// MARK: - DataSource
extension BudgetListViewController: UITableViewDataSource {
    enum Section: Int {
        case currentMonth = 0
        case categories = 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.cells.value.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cells.value[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cells.value[indexPath.section][indexPath.row]
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ListStyleTableViewHeader()
        view.text = viewModel.sectionTitles[section]
        
        if section == Section.categories.rawValue {
            let editButton = UIButton()
            editButton.setTitle("Edit", for: .normal)
            editButton.setTitleColor(.systemBlue, for: .normal)
            editButton.addTarget(self, action: #selector(didTapEditBudgets), for: .touchUpInside)
            view.rightView = editButton
        }
        return view
    }
}
// MARK: - Delegate
extension BudgetListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }

        guard
            let coordinator = coordinator as? BudgetCoordinator,
            let section = Section(rawValue: indexPath.section)
        else { return }

        switch section {
        case .currentMonth:
            // Upcoming payments section
            if indexPath.row == 1 {
                coordinator.showPocket()
            }
            return
        case .categories:
            guard let itemID = viewModel.getBudgetItemID(at: indexPath) else { return }
            coordinator.showBudgetDetail(itemID)
        }
    }
}
