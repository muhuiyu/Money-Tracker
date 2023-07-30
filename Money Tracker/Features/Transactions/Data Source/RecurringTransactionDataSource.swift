//
//  RecurringTransactionDataSource.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/3/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

struct RecurringTransactionDataSource {
    typealias DataSource = RxTableViewSectionedReloadDataSource

    static func dataSource() -> DataSource<RecurringTransactionSection> {
        return DataSource<RecurringTransactionSection>(
            configureCell: { dataSource, tableView, indexPath, item -> UITableViewCell in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: RecurringTransactionCell.reuseID, for: indexPath) as? RecurringTransactionCell else {
                    return UITableViewCell()
                }
                cell.viewModel.recurringTransaction.accept(item)
                return cell

            }, titleForHeaderInSection: { dataSource, index in
                return dataSource.sectionModels[index].header
            }
        )
    }
}




