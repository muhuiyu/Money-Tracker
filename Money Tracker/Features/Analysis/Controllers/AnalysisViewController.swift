//
//  AnalysisViewController.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/3/22.
//

import UIKit
import RxSwift

class AnalysisViewController: Base.MVVMViewController<AnalysisViewModel> {
    
    // MARK: - View
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    
    // MARK: - View Models
    var transactionListViewModel = TransactionListViewModel()
//    let reloadOption: TransactionListViewModel.ReloadTransactionsOption = .inGivenMonth(Date.today.year, Date.today.month)
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel.reloadMonthlyExpenses {
//            self.configureViews()
//            self.configureConstraints()
//            self.configureBindings()
//        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        transactionListViewModel.reloadTransactions(reloadOption)
    }
}
// MARK: - TapHandlers
//extension AnalysisViewController {
//    @objc
//    func didPullToRefresh(_ sender: UIRefreshControl) {
//        // TODO: - Update transactions
////        refreshControl.beginRefreshing()
////        transactionListViewModel.reloadTransactions(reloadOption) {
////            self.refreshControl.endRefreshing()
////        }
//    }
//}
//// MARK: - View Config
//extension AnalysisViewController {
//    private func reconfigureHeaderView() {
//        let viewController = viewModel.getHeaderViewController()
//        pageViewController.setViewControllers([viewController], direction: .forward, animated: false)
//    }
//    private func configureViews() {
//        reconfigureHeaderView()
//        pageViewController.dataSource = self
//        pageViewController.delegate = self
//        addChild(pageViewController)
//        view.addSubview(pageViewController.view)
//
//        refreshControl.addTarget(self,
//                                 action: #selector(didPullToRefresh(_:)),
//                                 for: .valueChanged)
//
//        tableView.refreshControl = refreshControl
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(AnalysisMainCategoryPreviewCell.self, forCellReuseIdentifier: AnalysisMainCategoryPreviewCell.reuseID)
//        view.addSubview(tableView)
//
//        view.layer.cornerRadius = 20
//    }
//    private func configureConstraints() {
//        pageViewController.view.snp.remakeConstraints { make in
//            make.height.equalTo(200)
//            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
//        }
//        tableView.snp.remakeConstraints { make in
//            make.top.equalTo(pageViewController.view.snp.bottom)
//            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
//        }
//    }
//    private func configureBindings() {
//        viewModel.displayMonthString
//            .asObservable()
//            .subscribe(onNext: { value in
//                self.title = value
//                self.reconfigureHeaderView()
//            })
//            .disposed(by: disposeBag)
//
//        viewModel.displayCategoryPreviewCells
//            .asObservable()
//            .subscribe { _ in
//                self.tableView.reloadData()
//            }
//            .disposed(by: disposeBag)
//    }
//}
//// MARK: - DataSource and Delegate from UIPageViewController
//extension AnalysisViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        viewModel.moveToPreviousMonth()
//        return LoadingViewController()
//    }
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        if viewModel.canMoveToNextMonth {
//            viewModel.moveToNextMonth()
//            return LoadingViewController()
//        } else {
//            return nil
//        }
//    }
//}
//// MARK: - Data Source
//extension AnalysisViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.displayCategoryPreviewCells.value.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return viewModel.displayCategoryPreviewCells.value[indexPath.row]
//    }
//}
//// MARK: - Delegate
//extension AnalysisViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        defer {
//            tableView.deselectRow(at: indexPath, animated: true)
//        }
//
//        guard
//            let coordinator = coordinator as? HomeCoordinator,
//            let categoryID = viewModel.getCategoryID(at: indexPath)
//        else { return }
//
//        coordinator.showMonthlyAnalysisCategoryDetail(viewModel.getExpenses(of: categoryID))
//    }
//}
//
