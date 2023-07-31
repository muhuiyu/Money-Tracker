//
//  Localized.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import Foundation

struct Localized {
    static var AppName: String { "APPNAME".localized }
}

extension Localized {
    struct General {
        static var cancel: String { "General.Cancel".localized }
        static var edit: String { "General.Edit".localized }
        static var add: String { "General.Add".localized }
        static var save: String { "General.Save".localized }
        static var pullToRefresh: String { "General.PullToRefresh".localized }
        static var search: String { "General.Search".localized }
    }
}

// MARK: - Loading Screen
extension Localized {
    struct Loading {
        static var title: String { "Loading".localized }
    }
}

// MARK: - Main Tab Bar
extension Localized {
    struct MainTab {
        static var home: String { "MainTab.Home".localized }
        static var analysis: String { "MainTab.Analysis".localized }
        static var budget: String { "MainTab.Budget".localized }
        static var me: String { "MainTab.Me".localized }
    }
}

// MARK: - Home
extension Localized {
    struct Home {
        static var balanceTitle: String { "Home.BalanceTitle".localized }
        static var addTransaction: String { "Home.AddTransaction".localized }
        static var accounts: String { "Home.Accounts".localized }
        static var pocket: String { "Home.Pocket".localized }
    }
}
// MARK: - Analysis
extension Localized {
    struct Analysis {
        static var totalExpense: String { "Analysis.TotalExpense".localized }
    }
}
// MARK: - Pocket
extension Localized {
    struct Pocket {
        static var title: String { "Pocket.Title".localized }
    }
}

// MARK: - Transaction
extension Localized {
    struct TransactionList {
        static var recentTransactions: String { "TransactionList.RecentTransactions".localized }
        static var seeAll: String { "TransactionList.SeeAll".localized }
    }
    
    struct TransactionDetail {
        static var addTransaction: String { "TransactionDetail.AddTransaction".localized }
        static var editTransaction: String { "TransactionDetail.EditTransaction".localized }
        static var transactionDetail: String { "TransactionDetail.TransactionDetail".localized }
        static var amount: String { "TransactionDetail.Amount".localized }
        static var enterAmount: String { "TransactionDetail.EnterAmount".localized }
        static var date: String { "TransactionDetail.Date".localized }
        static var category: String { "TransactionDetail.Category".localized }
        static var addCategory: String { "TransactionDetail.AddCategory".localized }
        static var paymentBy: String { "TransactionDetail.PaymentBy".localized }
        static var addPaymentMethod: String { "TransactionDetail.AddPaymentMethod".localized }
        static var merchant: String { "TransactionDetail.Merchant".localized }
        static var addMerchant: String { "TransactionDetail.AddMerchant".localized }
        static var tag: String { "TransactionDetail.Tag".localized }
        static var addTag: String { "TransactionDetail.AddTag".localized }
        static var isRecurring: String { "TransactionDetail.IsRecurring".localized }
        static var note: String { "TransactionDetail.Note".localized }
        static var addNote: String { "TransactionDetail.AddNote".localized }
    }
}

// MARK: - Budget
extension Localized {
    struct Budget {
        static var title: String { "Budget.Title".localized }
        static var thisMonth: String { "Budget.ThisMonth".localized }
        static var categoryBudgets: String { "Budget.CategoryBudgets".localized }
        static var editBudget: String { "Budget.EditBudget".localized }
        static var editBudgetTitle: String { "Budget.EditBudgetTitle".localized }
        static var upcomingPayments: String { "Budget.UpcomingPayments".localized }
        static var safeToSpend: String { "Budget.SafeToSpend".localized }
        static var overspent: String { "Budget.Overspent".localized }
    }
}

// MARK: - Language
extension Localized {
    struct Language {
        static var Title: String { "Language.Title".localized }
        static var en: String { "Language.en".localized }
        static var ja: String { "Language.ja".localized }
        static var vi: String { "Language.vi".localized }
        static var changeLanguage: String { "Language.changeLanguage".localized }
    }
}
