//
//  ExportViewController.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 8/1/23.
//

import UIKit

class ExportViewController: BaseViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private lazy var cells: [UITableViewCell] = [
        walletCell,
        categoryCell,
        typeCell,
        periodCell
    ]
    
    private let walletCell = UITableViewCell()
    private let categoryCell = UITableViewCell()
    private let typeCell = UITableViewCell()
    private let periodCell = UITableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
    }
}
// MARK: - View Config
extension ExportViewController {
    private func configureViews() {
        view.addSubview(tableView)
    }
    private func configureConstraints() {
        tableView.snp.remakeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

