//
//  MainTabBarController.swift
//  PizzaApp
//
//  Created by Ramazan Abdulaev on 14.10.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.backgroundColor = .darkWhite
        tabBar.barTintColor = .white
        tabBar.tintColor = .red
        
        let menuViewModel = MenuViewModel()
        let menuVC = MenuVC(viewModel: menuViewModel)
        
        let contatsVC = UIViewController()
        let profileVC = UIViewController()
        let basketVC = UIViewController()
        
        viewControllers = [
            createNavigationController(rootViewController: menuVC,
            title: "Меню",
            image: UIImage(named: "fast-food")),
            
            createNavigationController(rootViewController: contatsVC,
            title: "Контаты",
            image: nil),
            
            createNavigationController(rootViewController: profileVC,
            title: "Профиль",
            image: nil),
            
            createNavigationController(rootViewController: basketVC,
            title: "Корзина",
            image: nil)
        ]
    }
    
    private func createNavigationController(rootViewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        navigationVC.navigationBar.backgroundColor = .darkWhite
        return navigationVC
    }
}
