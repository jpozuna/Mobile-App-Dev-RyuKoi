//
//  BottomNavigationViewController.swift
//  Group6_RyuKoi
//
//  Created by R M on 11/17/25.
//

import UIKit

class BottomNavigationViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.backgroundColor = UIColor(red: 1.0, green: 248/255, blue: 232/255, alpha: 1.0)
        tabBar.tintColor = UIColor(red: 59/255, green: 9/255, blue: 24/255, alpha: 1.0)
        tabBar.unselectedItemTintColor = UIColor(red: 59/255, green: 9/255, blue: 24/255, alpha: 1.0)
        
        //MARK: setting up home tab bar...
        let tabHome = UINavigationController(rootViewController: CategoriesViewController())
        let tabHomeBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.filled")
        )
        
        tabHome.tabBarItem = tabHomeBarItem
        tabHome.title = "Home"
        
        //MARK: setting up favorites tab bar...
        let tabFavorites = UINavigationController(rootViewController: FavoritesViewController())
        let tabFavoriteBarItem = UITabBarItem(
            title: "Favorties",
            image: UIImage(systemName: "bookmark"),
            selectedImage: UIImage(systemName: "bookmark.fill")
        )
        tabFavorites.tabBarItem = tabFavoriteBarItem
        tabFavorites.title = "Favorites"
        
        //MARK: setting up events tab bar...
        let tabEvents = UINavigationController(rootViewController: CommunitiesViewController())
        let tabEventsBarItem = UITabBarItem(
            title: "Events",
            image: UIImage(systemName: "bell"),
            selectedImage: UIImage(systemName: "bell.fill")
        )
        tabEvents.tabBarItem = tabEventsBarItem
        tabEvents.title = "Events"
        
        //MARK: setting up this view controller as the Tab Bar Controller...
        self.viewControllers = [tabHome, tabFavorites, tabEvents]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
