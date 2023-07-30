//
//  RecurringTransactionSection.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/4/22.
//

import RxDataSources

struct RecurringTransactionSection: Codable {
    var header: String
    var items: [Item]
    
    init(header: String, items: [Item]) {
        self.header = header
        self.items = items
    }
}

extension RecurringTransactionSection {
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

extension RecurringTransactionSection: SectionModelType {
    typealias Item = RecurringTransaction
    
    init(original: RecurringTransactionSection, items: [Item]) {
        self = original
        self.items = items
    }
}

