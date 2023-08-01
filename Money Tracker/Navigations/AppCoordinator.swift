//
//  AppCoordinator.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import UIKit
import RxSwift

class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let disposeBag = DisposeBag()
    
    var childCoordinators = [TabBarCategory: BaseCoordinator]()
    private(set) var mainTabBarController: MainTabBarController?
    
    let dataProvider: Database
    private(set) var userManager = UserManager()
//    private(set) var cacheManager = CacheManager()
    
    init?(window: UIWindow?, dataProvider: Database?) {
        guard let window = window, let dataProvider = dataProvider else { return nil }
        self.window = window
        self.dataProvider = dataProvider
    }


    func start() {
        configureBindings()
        showLoadingScreen()
        configureCoordinators()
        setupMainTabBar()
        configureDatabase()
        showHome()
        window.makeKeyAndVisible()
    }
    
    private func configureBindings() {
        
    }

}

// MARK: - Services and managers
extension AppCoordinator {
    private func configureDatabase() {
        dataProvider.setup()
    }
}

// MARK: - UI Setup
extension AppCoordinator {
    /// Initializes coordinators
    private func configureCoordinators() {
        // Tab coordinators have their own different navigationControllers
        childCoordinators[.home] = HomeCoordinator(navigationController: UINavigationController(),
                                                   parentCoordinator: self)
        childCoordinators[.budget] = BudgetCoordinator(navigationController: UINavigationController(),
                                                       parentCoordinator: self)
        childCoordinators[.analysis] = AnalysisCoordinator(navigationController: UINavigationController(),
                                                           parentCoordinator: self)
        childCoordinators[.me] = MeCoordinator(navigationController: UINavigationController(),
                                               parentCoordinator: self)
    }
    private func setupMainTabBar() {
        mainTabBarController = MainTabBarController()
        mainTabBarController?.appCoordinator = self
        mainTabBarController?.configureTabBarItems()
    }
}

// MARK: - Generic Navigation
extension AppCoordinator {
    enum Destination {
        case home
        case loadingScreen
    }
    private func changeRootViewController(to viewController: UIViewController?) {
        guard let viewController = viewController else { return }
        window.rootViewController = viewController
    }
    func showHome(forceReplace: Bool = true, animated: Bool = true) {
        changeRootViewController(to: self.mainTabBarController)
    }
    func showLoadingScreen(forceReplace: Bool = false, animated: Bool = true) {
        let viewController = LoadingScreenViewController(appCoordinator: self)
        changeRootViewController(to: viewController)
    }
}
