//
//  QuickAddViewController.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 8/2/23.
//

import UIKit
import RxSwift
import RxRelay

protocol QuickAddViewControllerDelegate: AnyObject {
    func quickAddViewControllerDidSelect(_ item: TransactionSettings)
}

class QuickAddViewController: Base.MVVMViewController<QuickAddViewModel> {
    
    private let segmentControl = UISegmentedControl(items: ["shortcut", "recurring"])
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    weak var delegate: QuickAddViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        configureBindings()
    }
}

// MARK: - View Config
extension QuickAddViewController {
    private func configureViews() {
        navigationItem.title = "Quick add transaction"
        segmentControl.addTarget(self, action: #selector(didChangeIndex(_:)), for: .valueChanged)
        view.addSubview(segmentControl)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(didTapEdit))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Icons.plus), style: .plain, target: self, action: #selector(didTapAdd))
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(QuickAddItemPreviewCell.self, forCellReuseIdentifier: QuickAddItemPreviewCell.reuseID)
        view.addSubview(tableView)
    }
    private func configureConstraints() {
        segmentControl.snp.remakeConstraints { make in
            make.top.leading.trailing.equalTo(view.layoutMarginsGuide)
        }
        tableView.snp.remakeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(Constants.Spacing.medium)
            make.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func configureBindings() {
        viewModel.currentMode
            .asObservable()
            .subscribe { value in
                self.segmentControl.selectedSegmentIndex = value.rawValue
            }
            .disposed(by: disposeBag)
        
        viewModel.items
            .asObservable()
            .subscribe { [weak self] _ in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            .disposed(by: disposeBag)
    }
    
    @objc
    private func didChangeIndex(_ sender: UISegmentedControl) {
        if let mode = QuickAddViewModel.Mode(rawValue: sender.selectedSegmentIndex) {
            viewModel.currentMode.accept(mode)
        }
    }
    
    @objc
    private func didTapEdit() {
        
    }
    
    @objc
    private func didTapAdd() {
        
    }
}

// MARK: - DataSource
extension QuickAddViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuickAddItemPreviewCell.reuseID, for: indexPath) as? QuickAddItemPreviewCell else { return UITableViewCell() }
        cell.item = viewModel.items.value[indexPath.row]
        cell.merchantName = viewModel.getMerchantName(at: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        delegate?.quickAddViewControllerDidSelect(viewModel.items.value[indexPath.row])
    }
}
