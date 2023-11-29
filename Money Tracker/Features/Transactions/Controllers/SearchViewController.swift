//
//  SearchViewController.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import UIKit
import RxSwift
import RxRelay

class SearchViewController: Base.MVVMViewController<SearchViewModel> {
    
    private let headerBackgroundView = UIView()
    private let headerView = UIView()
    private let backButton = IconButton(icon: UIImage(systemName: Icons.chevronBackward))
    private let searchTextFieldContainer = UIView()
    private let searchTextField = UITextField()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        configureBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hidesBottomBarWhenPushed = false
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK: - View Config
extension SearchViewController {
    private func configureViews() {
        headerBackgroundView.backgroundColor = .white
        view.addSubview(headerBackgroundView)
        
        backButton.tapHandler = { [weak self] in
            self?.didTapBack()
        }
        headerView.addSubview(backButton)
        searchTextField.placeholder = "Search by category, notes..."
        searchTextField.addTarget(self, action: #selector(didChangeValue(_:)), for: .editingChanged)
        searchTextField.backgroundColor = .secondarySystemBackground
        searchTextField.font = .small
        searchTextField.layer.cornerRadius = 20
        searchTextFieldContainer.addSubview(searchTextField)
        searchTextFieldContainer.backgroundColor = .secondarySystemBackground
        searchTextFieldContainer.layer.borderColor = UIColor.systemGray.cgColor
        
        headerView.addSubview(searchTextFieldContainer)
        headerView.backgroundColor = .white
        view.addSubview(headerView)

        tableView.backgroundColor = .secondarySystemBackground
        tableView.register(TransactionPreviewCell.self, forCellReuseIdentifier: TransactionPreviewCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        view.backgroundColor = .secondarySystemBackground
    }
    private func configureConstraints() {
        backButton.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.size.equalTo(24)
        }
        searchTextField.snp.remakeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.Spacing.small)
        }
        searchTextFieldContainer.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constants.Spacing.small)
            make.leading.equalTo(backButton.snp.trailing).offset(Constants.Spacing.medium)
            make.trailing.equalToSuperview().inset(Constants.Spacing.trivial)
        }
        headerBackgroundView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(headerView.snp.bottom)
        }
        headerView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalTo(view.layoutMarginsGuide)
        }
        tableView.snp.remakeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func configureBindings() {
        viewModel.result
            .asObservable()
            .subscribe { [weak self] _ in
                self?.tableView.reloadData()
            }
            .disposed(by: disposeBag)
    }
    @objc
    private func didChangeValue(_ sender: UITextField) {
        if let text = sender.text {
            viewModel.searchQuery.accept(text)
        }
    }
    private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.result.value.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionPreviewCell.reuseID, for: indexPath) as? TransactionPreviewCell else { return UITableViewCell() }
        cell.viewModel.transaction.accept(viewModel.result.value[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

