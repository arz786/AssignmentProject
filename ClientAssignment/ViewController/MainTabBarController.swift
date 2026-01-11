//
//  MainTabBarController.swift
//  ClientAssignment
//
//  Created by Arzu Mozammil on 10/01/2026.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }

    private func setupTabs() {

        let repository = PostRepository()

        let postsVC = PostsViewController(
            viewModel: PostsViewModel(repository: repository)
        )
        let favoritesVC = FavoritesViewController(
            viewModel: FavoritesViewModel(repository: repository)
        )

        postsVC.title = "Posts"
        favoritesVC.title = "Favorites"

        let postsNav = UINavigationController(rootViewController: postsVC)
        let favoritesNav = UINavigationController(rootViewController: favoritesVC)

        postsNav.tabBarItem = UITabBarItem(
            title: "Posts",
            image: UIImage(systemName: "list.bullet"),
            tag: 0
        )

        favoritesNav.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(systemName: "heart.fill"),
            tag: 1
        )

        viewControllers = [postsNav, favoritesNav]
    }
}
