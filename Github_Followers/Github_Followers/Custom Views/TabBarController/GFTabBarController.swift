//
//  GFTabBarController.swift
//  Github_Followers
//
//  Created by AressMacMiniA1993 on 23/10/24.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor         = .systemGreen
        viewControllers                         = [createSearchNC(),createFavoriteNC()]
        UITabBar.appearance().backgroundColor   = .white
    }

    // Search view controller
    func createSearchNC() -> UINavigationController {
        let searchVC        = SearchVC()
        searchVC.title      = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }

    func createFavoriteNC() -> UINavigationController {
        let favoriteVC          = favoritesVC()
        favoriteVC.title        = "Favorites"
        favoriteVC.tabBarItem   = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoriteVC)
    }
}
