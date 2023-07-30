//
//  TransactionSection.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import RxDataSources

struct TransactionSection: Codable {
    var header: String
    var items: [Item]
    
    init(header: String, items: [Item]) {
        self.header = header
        self.items = items
    }
}

extension TransactionSection {
    private enum CodingKeys: String, CodingKey {
        case header
        case items
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        header = try container.decode(String.self, forKey: .header)
        items = try container.decode([Item].self, forKey: .items)
    }
}

extension TransactionSection: SectionModelType {
    typealias Item = Transaction
    
    init(original: TransactionSection, items: [Item]) {
        self = original
        self.items = items
    }
}
typealias TransactionSections = [TransactionSection]
extension TransactionSections {
    func sortedByDate() -> [TransactionSection] {
        return self.sorted { a, b in
            guard let aDate = a.items.first?.date, let bDate = b.items.first?.date else { return false }
            return aDate > bDate
        }
    }
}
