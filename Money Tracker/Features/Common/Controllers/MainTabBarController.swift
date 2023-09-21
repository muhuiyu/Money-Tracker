//
//  MainTabBarController.swift
//  Fastiee
//
//  Created by Mu Yu on 6/25/22.
//

import UIKit

class MainTabBarController: UITabBarController {
    weak var appCoordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

// MARK: - View Configs
extension MainTabBarController {
    func configureTabBarItems() {
        configureInitialTabBarItems()
    }
    
    private func configureInitialTabBarItems() {
        var mainViewControllers = [UINavigationController]()
        TabBarCategory.allCases.forEach { [weak self] category in
            if let viewController = self?.generateViewController(category) {
                mainViewControllers.append(viewController)
            }
        }
        self.viewControllers = mainViewControllers
    }
    
    private func generateViewController(_ category: TabBarCategory) -> UINavigationController? {
        let viewController = category.getViewController(appCoordinator)
        
        appCoordinator?
            .childCoordinators[category]?
            .navigationController
            .setViewControllers([viewController], animated: true)
        
        return appCoordinator?.childCoordinators[category]?.navigationController
    }
}

// MARK: - UITabBarControllerDelegate
extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // detect when the user taps on the tab and define the action for something else
        // instead of showing the view controller as other tabs
        if
            let viewController = viewController as? UINavigationController,
            let _ = viewController.findViewController(MainActionViewController.self),
            let coordinator = self.appCoordinator?.childCoordinators[.action] as? MainActionCoordinator {
            
            coordinator.showAddTransaction()
            return false
        }
        return true
    }
}

enum TabBarCategory: Int, CaseIterable {
    case home = 0
    case analysis
    case action
    case budget
    case me
    
    var title: String {
        switch self {
        case .home: return Localized.MainTab.home
        case .analysis: return Localized.MainTab.analysis
        case .action: return "Action"
        case .budget: return Localized.MainTab.budget
        case .me: return Localized.MainTab.me
        }
    }
    var inactiveImageValue: UIImage? {
        switch self {
        case .home: return UIImage(systemName: Icons.dollarsignCircle)
        case .analysis: return UIImage(systemName: Icons.chartBar)
        case .action: return UIImage(systemName: Icons.plusCircleFill)
        case .budget: return UIImage(systemName: Icons.plusminus)
        case .me: return UIImage(systemName: Icons.person)
        }
    }
    var activeImageValue: UIImage? {
        switch self {
        case .home: return UIImage(systemName: Icons.dollarsignCircleFill)
        case .analysis: return UIImage(systemName: Icons.chartBarFill)
        case .action: return UIImage(systemName: Icons.plusCircleFill)?.withBaselineOffset(fromBottom: 6.0)
        case .budget: return UIImage(systemName: Icons.plusminusFill)
        case .me: return UIImage(systemName: Icons.personFill)
        }
    }
    func getViewController(_ appCoordinator: AppCoordinator?) -> BaseViewController {
        let viewController: BaseViewController
        
        switch self {
        case .home:
            viewController = HomeViewController(viewModel: HomeViewModel(appCoordinator: appCoordinator))
        case .analysis:
            viewController = AnalysisViewController(viewModel: AnalysisViewModel(appCoordinator: appCoordinator))
        case .action:
            viewController = MainActionViewController(appCoordinator: appCoordinator)
        case .budget:
            viewController = BudgetListViewController(viewModel: BudgetListViewModel(appCoordinator: appCoordinator))
        case .me:
            viewController = MeViewController(viewModel: MeViewModel(appCoordinator: appCoordinator))
        }
        
        viewController.appCoordinator = appCoordinator
        viewController.coordinator = appCoordinator?.childCoordinators[self]
        viewController.tabBarItem = self.tabBarItem
        return viewController
    }
    var tabBarItem: UITabBarItem {
        let item = UITabBarItem(title: self.title, image: self.inactiveImageValue, tag: self.rawValue)
        item.selectedImage = self.activeImageValue
        return item
    }
}

// MARK: - MainActionViewController (it's empty)
class MainActionViewController: BaseViewController {
    
}
