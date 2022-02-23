//
//  DashboardCoordinator.swift
//  MyMovieList
//

import UIKit

final class DashboardCoordinator: Coordinator {  
  private(set) var tabBarController: UITabBarController?
  
  var childCoordinators: [Coordinator] = []
  var isCompleted: Observable<Bool>?
  
  init(tabBarController: UITabBarController) {
    self.tabBarController = tabBarController
  }
  
  func start() {
    let homeNavigationController = UINavigationController()
    homeNavigationController.tabBarItem = UITabBarItem(
      title: Strings.movies,
      image: UIImage(systemName: "tv"),
      selectedImage: UIImage(systemName: "tv.fill")
    )
    let homeCoordinator = HomeCoordinator(navigationController: homeNavigationController)
    homeCoordinator.start()
    
    let favoriteNavigationController = UINavigationController()
    favoriteNavigationController.tabBarItem = UITabBarItem(
      title: Strings.favorites,
      image: UIImage(systemName: "bookmark"),
      selectedImage: UIImage(systemName: "bookmark.fill")
    )
    let favoriteCoordinator = FavoriteCoordinator(navigationController: favoriteNavigationController)
    favoriteCoordinator.start()
    
    homeNavigationController.hidesBottomBarWhenPushed = false
    tabBarController?.setViewControllers(
      [homeNavigationController, favoriteNavigationController],
      animated: true
    )
    
    store(coordinator: homeCoordinator)
    store(coordinator: favoriteCoordinator)
  }
}
