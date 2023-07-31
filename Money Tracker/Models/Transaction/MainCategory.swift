//
//  MainCategory.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import Foundation

typealias MainCategoryID = String

// MARK: - Main Category
struct MainCategory: Codable {
    let id: MainCategoryID
    let name: String
    let iconName: String
}
// MARK: - Interface
extension MainCategory {
    static func getName(of id: String, isLocalized: Bool = false) -> String? {
        // TODO: - Add localized
        return all[id]?.name
    }
    static func getIconName(of id: String) -> String? {
        return all[id]?.iconName
    }
    static func getAllNames(isLocalized: Bool = false) -> [String] {
        // TODO: - Add localized
        return all.map { $0.value.name }
    }
    static func getAllIDs() -> [CategoryID] {
        return Array(all.keys)
    }
}
// MARK: - Coder
extension MainCategory {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case iconName
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(CategoryID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        iconName = try container.decode(String.self, forKey: .iconName)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(iconName, forKey: .iconName)
    }
}
// MARK: - Items
extension MainCategory {
    private static let all: [CategoryID: MainCategory] = [
        "1": MainCategory(id: "1", name: "Property", iconName: Icons.house),
        "2": MainCategory(id: "2", name: "Food", iconName: Icons.forkKnife),
        "3": MainCategory(id: "3", name: "Utilities", iconName: Icons.boltFill),
        "4": MainCategory(id: "4", name: "Transport", iconName: Icons.bus),
        "5": MainCategory(id: "5", name: "Daily Incidentals", iconName: Icons.eyeglasses),
        "6": MainCategory(id: "6", name: "Gifts", iconName: Icons.gift),
        "7": MainCategory(id: "7", name: "Subscription", iconName: Icons.playTvFill),
        "8": MainCategory(id: "8", name: "Education", iconName: Icons.textBookClosedFill),
        "9": MainCategory(id: "9", name: "Travel", iconName: Icons.airplane),
        "10": MainCategory(id: "10", name: "Insurance", iconName: Icons.dollarsignCircleFill),
        "11": MainCategory(id: "11", name: "Health", iconName: Icons.crossCaseFill),
        "12": MainCategory(id: "12", name: "Entertainment", iconName: Icons.filmFill),
        "13": MainCategory(id: "13", name: "PersonalCare", iconName: Icons.heartFill),
        "14": MainCategory(id: "14", name: "Charity", iconName: Icons.heartFill),
        "15": MainCategory(id: "15", name: "Investment", iconName: Icons.dollarsignCircleFill),
    ]
}
