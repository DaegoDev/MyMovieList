//
//  AppCoordinator.swift
//  MyMovieList
//

import UIKit

final class AppCoordinator: Coordinator {
  private let window: UIWindow
  private(set) var navigationController: UINavigationController?
  private(set) var tabBarController: UITabBarController?

  var childCoordinators: [Coordinator] = []
  var isCompleted: Observable<Bool>?

  init(window: UIWindow) {
    self.window = window
    self.navigationController = UINavigationController()
    self.tabBarController = UITabBarController()
  }
  
  func start() {
    guard let tabBarController = tabBarController else { return }
    let dasboardCoordinator = DashboardCoordinator(tabBarController: tabBarController)
    dasboardCoordinator.start()
    store(coordinator: dasboardCoordinator)
    window.rootViewController = tabBarController
    window.makeKeyAndVisible()
  }
}
