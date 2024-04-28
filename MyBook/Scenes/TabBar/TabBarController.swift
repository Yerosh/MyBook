//
//  TabBarController.swift
//  MyBook
//
//  Created by Yernur Adilbek on 3/30/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor(red: 51/255, green: 45/255, blue: 65/255, alpha: 1)
        tabBar.tintColor = .white
        view.backgroundColor = UIColor(red: 51/255, green: 45/255, blue: 65/255, alpha: 1)
    }
    
    private func setupTabs(){
        let store = self.createNav(title: "Store", image: UIImage(systemName: "case.fill"), vc: ViewController())
        let library = self.createNav(title: "Library", image: UIImage(systemName: "books.vertical.fill"), vc: LibraryViewController())
        let search = self.createNav(title: "Search", image: UIImage(systemName: "magnifyingglass"), vc: StoreViewController())
        self.setViewControllers([store, library, search], animated: true)
    }
    
    private func createNav(title: String, image: UIImage?, vc: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        nav.tabBarItem.image = image
        nav.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        nav.viewControllers.first?.navigationItem.title = title
        return nav
    }
}
