//
//  MeViewController.swift
//  Fastiee
//
//  Created by Mu Yu on 6/25/22.
//

import UIKit
import RxSwift

class MeViewController: Base.MVVMViewController<MeViewModel> {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private lazy var cells: [[UITableViewCell]] = [
        [
            recurringTransactionsCell
        ],
        [
            mainCurrencyCell,
            walletsCell,
        ],
        [
            exportCell
        ]
    ]
    
    private let mainCurrencyCell = UITableViewCell()
    private let recurringTransactionsCell = UITableViewCell()
    private let walletsCell = UITableViewCell()
    private let exportCell = UITableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        configureGestures()
        configureBindings()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
// MARK: - Handlers
extension MeViewController {
    @objc
    private func didTapSettings() {
        // TODO: - Add settings page
        print("didTapSettings")
    }
}
// MARK: - View Config
extension MeViewController {
    private func configureViews() {
        title = viewModel.displayTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Icons.gearshape),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapSettings))
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        configureCells()
    }
    private func configureConstraints() {
        tableView.snp.remakeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func configureGestures() {
        
    }
    private func configureBindings() {
        
    }
    private func configureCells() {
        configureRecurringTransaction()
        configureMainCurrencyCell()
        configureWalletsCell()
        configureExportCell()
    }
    private func configureRecurringTransaction() {
        var content = recurringTransactionsCell.defaultContentConfiguration()
        content.text = "Recurring transactions"
        recurringTransactionsCell.accessoryType = .disclosureIndicator
        recurringTransactionsCell.contentConfiguration = content
    }
    private func configureMainCurrencyCell() {
        var content = mainCurrencyCell.defaultContentConfiguration()
        content.text = "Main currency"
        mainCurrencyCell.accessoryType = .disclosureIndicator
        mainCurrencyCell.contentConfiguration = content
    }
    private func configureWalletsCell() {
        var content = walletsCell.defaultContentConfiguration()
        content.text = "Wallets"
        walletsCell.accessoryType = .disclosureIndicator
        walletsCell.contentConfiguration = content
    }
    private func configureExportCell() {
        var content = exportCell.defaultContentConfiguration()
        content.text = "Export"
        exportCell.accessoryType = .disclosureIndicator
        exportCell.contentConfiguration = content
    }
}

// MARK: - DataSource and Delegate
extension MeViewController: UITableViewDataSource, UITableViewDelegate {
    enum Section {
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.section][indexPath.row]
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        guard let coordinator = coordinator as? MeCoordinator else { return }
        // 0, 0: recurring
        // 1, 0: main currency
        // 1, 1: wallets
        
        // TODO: - Change to
        if indexPath.section == 0 && indexPath.row == 0 {
            coordinator.showRecurringTransactions()
        } else if indexPath.section == 1 && indexPath.row == 0 {
            coordinator.showMainCurrency()
        } else {
            coordinator.showWallets()
        }
    }
}
