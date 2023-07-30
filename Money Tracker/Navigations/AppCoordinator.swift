//
//  AppCoordinator.swift
//  Fastiee
//
//  Created by Mu Yu on 6/25/22.
//

import UIKit
import RxSwift

class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let disposeBag = DisposeBag()
    
    var childCoordinators = [TabBarCategory: BaseCoordinator]()
    private(set) var mainTabBarController: MainTabBarController?
    private(set) var loadingScreenController: LoadingScreenViewController?
    
    let dataProvider: RealmDatabase
    private(set) var userManager = UserManager()
//    private(set) var cacheManager = CacheManager()
    
    init?(window: UIWindow?, dataProvider: RealmDatabase?) {
        guard let window = window, let dataProvider = dataProvider else { return nil }
        self.window = window
        self.dataProvider = dataProvider
    }


    func start() {
        configureSignals()
        configureLoadingScreen()
        configureCoordinators()
        setupMainTabBar()
        
        Task {
            await configureDatabase()
            DispatchQueue.main.async {
                print("should show home")
                self.showHome()
            }
        }
        
        window.makeKeyAndVisible()
    }
    
    private func configureSignals() {
        
    }

}

// MARK: - Services and managers
extension AppCoordinator {
    private func configureDatabase() async {
        dataProvider.setup()
    }
}

// MARK: - UI Setup
extension AppCoordinator {
    /// Sets loading screen as rootViewController and embeds in a navigationController
    private func configureLoadingScreen() {
        loadingScreenController = LoadingScreenViewController(appCoordinator: self)
    }
    /// Initializes coordinators
    private func configureCoordinators() {
        // Tab coordinators have their own different navigationControllers
        childCoordinators[.home] = HomeCoordinator(navigationController: UINavigationController(),
                                                   parentCoordinator: self)
        childCoordinators[.budget] = BudgetCoordinator(navigationController: UINavigationController(),
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
    private func changeRootViewController(to viewController: UIViewController?) {
        guard let viewController = viewController else { return }
        window.rootViewController = viewController
    }
    func showHome(forceReplace: Bool = true, animated: Bool = true) {
        changeRootViewController(to: self.mainTabBarController)
    }
    func showLoadingScreen(forceReplace: Bool = false, animated: Bool = true) {
        changeRootViewController(to: self.loadingScreenController)
    }
}
