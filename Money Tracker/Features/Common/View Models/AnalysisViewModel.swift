//
//  AnalysisViewModel.swift
//  Why am I so poor
//
//  Created by Grace, Mu-Hui Yu on 8/5/22.
//

import UIKit
import RxSwift
import RxRelay

class AnalysisViewModel {
    private let disposeBag = DisposeBag()
    lazy var transactionDataSource = TransactionDataSource.dataSource()
    
    // MARK: - Reactive properties
    private var expenses: BehaviorRelay<TransactionList> = BehaviorRelay(value: [])
    var displayCategoryPreviewCells: BehaviorRelay<[AnalysisMainCategoryPreviewCell]> = BehaviorRelay(value: [])
    var displayExpenses: BehaviorRelay<[TransactionSection]> = BehaviorRelay(value: [])
    var displayMonthString: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var averageMonthlyExpense: Double = 0
    var monthAndYear: MonthAndYear? {
        didSet {
            reloadMonthlyExpenses()
        }
    }
    init() {
        configureSignals()
    }
}

extension AnalysisViewModel {
    var monthlyExpenseAmount: Double { return expenses.value.map(\.amount).reduce(0, +) }
    func getHeaderViewController() -> UIViewController {
        guard
            let monthAndYear = self.monthAndYear,
            let month = Date.MonthInNumber(rawValue: monthAndYear.month) else {
            return UIViewController()
        }
        let data = self.expenses.value.accumulateInDays(in: month, of: monthAndYear.year, shouldRoundOffToInt: true)
        let viewController = AnalysisHeaderViewController(monthAndYear: monthAndYear,
                                                          averageExpense: averageMonthlyExpense,
                                                          expenseData: data)
        return viewController
    }
    func moveToPreviousMonth() {
        guard let monthAndYear = monthAndYear else { return }
        self.monthAndYear = monthAndYear.previousMonth
    }
    var canMoveToNextMonth: Bool {
        guard let monthAndYear = monthAndYear else { return false }
        return !monthAndYear.isCurrentMonth
    }
    func moveToNextMonth() {
        guard let monthAndYear = monthAndYear else { return }
        self.monthAndYear = monthAndYear.nextMonth
    }
}
extension AnalysisViewModel {
    func reloadMonthlyExpenses(completion: (() -> Void)? = nil) {
        guard let date = monthAndYear else { return }
        getMonthlyExpenses(year: date.year, month: date.month, shouldPull: true) { result in
            switch result {
            case .success:
                self.updateMainCategoriedExpenses()
            case .failure(let error):
                ErrorHandler.shared.handle(error)
            }
            if let completion = completion {
                return completion()
            }
        }
    }
    func getCategoryID(at indexPath: IndexPath) -> CategoryID? {
        return displayCategoryPreviewCells.value[indexPath.row].mainCategoryID
    }
    func getExpenses(of mainCategoryID: CategoryID) -> TransactionList {
        return expenses.value.filter { $0.mainCategoryID == mainCategoryID }
    }
    func updateMainCategoriedExpenses() {
        let categoriedExpenses: [TransactionList] = expenses.value.groupedByMainCategory().values.sorted(by: { $0.totalAmount > $1.totalAmount })
        
        let cells: [AnalysisMainCategoryPreviewCell] = categoriedExpenses.map { transactions in
            let cell = AnalysisMainCategoryPreviewCell()
            cell.mainCategoryID = transactions[0].mainCategoryID
            cell.numberOfTransactionsString = "\(transactions.count) transactions"
            cell.signedAmount = transactions.reduce(0, { $0 + $1.signedAmount })
            return cell
        }
        displayCategoryPreviewCells.accept(cells)
    }
}

extension AnalysisViewModel {
    private func configureSignals() {
        self.expenses
            .asObservable()
            .subscribe { _ in
                let sections: [TransactionSection] = self.expenses.value.groupedByDay()
                    .map { TransactionSection(header: $0, items: $1) }
                    .sortedByDate()
                self.displayExpenses.accept(sections)
                if let monthString = self.monthAndYear?.toMonthAndYearString {
                    self.displayMonthString.accept(monthString)
                }
            }
            .disposed(by: disposeBag)
    }
    private func getMonthlyExpenses(year: Int,
                                    month: Int,
                                    shouldPull: Bool,
                                    completion: @escaping(VoidResult) -> Void) {
//        Database.shared.getMonthlyTransactions(year: year,
//                                               month: month,
//                                               calculateExpenseOnly: true,
//                                               shouldPull: shouldPull) { result in
//            switch result {
//            case .failure(let error):
//                self.expenses.accept([])
//                return completion(.failure(error))
//            case .success(let data):
//                self.expenses.accept(data)
//                if shouldPull {
//                    self.averageMonthlyExpense = Database.shared.getMonthlyAverageExpense()
//                }
//                return completion(.success)
//            }
//        }
    }
}
