//
//  HomeQuickAction.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 8/1/23.
//

import UIKit

enum ActionType: String {
  case newEntry
}

enum Action: Equatable {
  case newEntry

  init?(shortcutItem: UIApplicationShortcutItem) {
    guard let type = ActionType(rawValue: shortcutItem.type) else {
      return nil
    }

    switch type {
    case .newEntry:
      self = .newEntry
    }
  }
}

// 6
class ActionService: ObservableObject {
  static let shared = ActionService()

  // 7
  @Published var action: Action?
}
