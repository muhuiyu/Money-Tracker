//
//  PickerViewController.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/7/22.
//

import UIKit

class PickerViewController: BaseViewController {
    private let tableView = UITableView()
    
    private let options: [String]
    private let text: String
    
    init(text: String, options: [String]) {
        self.text = text
        self.options = options
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
    }
}
// MARK: - View Config
extension PickerViewController {
    private func configureViews() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    private func configureConstraints() {
        tableView.snp.remakeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Data Source
extension PickerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = options[indexPath.row]
        cell.accessoryType = .checkmark
        
        // TODO: - do something
        cell.isSelected = false
        return cell
    }
}

// MARK: - Delegate
extension PickerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        defer {
//            tableView.deselectRow(at: indexPath, animated: true)
//        }
        // TODO: - do something
    }
}

