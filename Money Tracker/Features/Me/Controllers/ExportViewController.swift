//
//  ExportViewController.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 8/1/23.
//

import UIKit

class ExportViewController: BaseViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let exportButton = TextButton(buttonType: .primary)
    
    private lazy var cells: [UITableViewCell] = [
        walletCell,
        categoryCell,
        typeCell,
        periodCell,
        fileTypeCell,
    ]
    
    private let walletCell = UITableViewCell()
    private let categoryCell = UITableViewCell()
    private let typeCell = UITableViewCell()
    private let periodCell = UITableViewCell()
    private let fileTypeCell = UITableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
    }
}

// MARK: - Handlers
extension ExportViewController {
    private func didTapExport() {
        
        // fetch transactions
        guard let transactions = appCoordinator?.dataProvider.getAllTransactions() else { return }
        
        do {
            // Convert to JSON Data
            let jsonData = try JSONEncoder().encode(transactions)
            
            // Optional: Convert to String for a more friendly console printout
            let jsonString = String(data: jsonData, encoding: .utf8)
            print("JSON String : " + jsonString!)
            
            // Get the directory to save the file
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let pathWithFileName = documentDirectory.appendingPathComponent("transactions_output.json")
            
            // Write to disk
            do {
                try jsonData.write(to: pathWithFileName)
                print("Successfully wrote to file at \(pathWithFileName)")
                
                let alert = UIAlertController(title: "Export successfully!", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true)
                
            } catch {
                print("An error occurred while writing the JSON to a file: ", error)
            }
            
        } catch {
            print("An error occurred while converting the Expense struct into JSON: ", error)
        }
    }
}

// MARK: - View Config
extension ExportViewController {
    private func configureViews() {
        title = "Export data"
        
        configureCells()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        exportButton.text = "Export"
        exportButton.buttonColor = .systemBlue
        exportButton.tapHandler = { [weak self] in
            self?.didTapExport()
        }
        view.addSubview(exportButton)
    }
    private func configureConstraints() {
        tableView.snp.remakeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        exportButton.snp.remakeConstraints { make in
            make.leading.trailing.equalTo(view.layoutMarginsGuide)
            make.bottom.equalTo(view.layoutMarginsGuide).inset(Constants.Spacing.large)
        }
    }
    private func configureCells() {
        configureWalletCell()
        configureCategoryCell()
        configureTypeCell()
        configurePeriodCell()
        configureFileTypeCell()
    }
    
    private func configureWalletCell() {
        var content = walletCell.defaultContentConfiguration()
        content.text = "Wallet"
        content.secondaryText = "All"
        walletCell.contentConfiguration = content
        walletCell.accessoryType = .disclosureIndicator
    }
    
    private func configureCategoryCell() {
        var content = categoryCell.defaultContentConfiguration()
        content.text = "Category"
        content.secondaryText = "All"
        categoryCell.contentConfiguration = content
        categoryCell.accessoryType = .disclosureIndicator
    }
    
    private func configureTypeCell() {
        var content = typeCell.defaultContentConfiguration()
        content.text = "Type"
        content.secondaryText = "All"
        typeCell.contentConfiguration = content
        typeCell.accessoryType = .disclosureIndicator
    }
    
    private func configurePeriodCell() {
        var content = periodCell.defaultContentConfiguration()
        content.text = "Period"
        content.secondaryText = "All"
        periodCell.contentConfiguration = content
        periodCell.accessoryType = .disclosureIndicator
    }
    
    private func configureFileTypeCell() {
        var content = fileTypeCell.defaultContentConfiguration()
        content.text = "File"
        content.secondaryText = "json"
        fileTypeCell.contentConfiguration = content
        fileTypeCell.accessoryType = .disclosureIndicator
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ExportViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.row]
    }
}
