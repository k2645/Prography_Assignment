//
//  TabBarController.swift
//  PrographyAssignment
//
//  Created by 김영현 on 1/29/24.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private lazy var homeTab: UINavigationController = {
        let viewController = HomeViewController(viewModel: HomeViewModelImpl())
        viewController.tabBarItem = UITabBarItem(title: nil, image: UIImage.house, selectedImage: UIImage.house)
        viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 20, bottom: -10, right: -20)
        setNavigationItem(viewController: viewController)
        
        return UINavigationController(rootViewController: viewController)
    }()
    
    private lazy var cardTab: UINavigationController = {
        let viewController = CardViewController()
        viewController.tabBarItem = UITabBarItem(title: nil, image: UIImage.cards, selectedImage: UIImage.cards)
        viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: -20, bottom: -10, right: 20)
        setNavigationItem(viewController: viewController)
        
        return UINavigationController(rootViewController: viewController)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBar()
    }
    
    override func viewDidLayoutSubviews() {
        var tabFrame = tabBar.frame
        tabFrame.size.height = 86
        tabFrame.origin.y = view.frame.size.height - 86
        tabBar.frame = tabFrame
    }
    
}

private extension TabBarController {
    
    func setTabBar() {
        tabBar.backgroundColor = UIColor.tabBarBackground
        tabBar.barTintColor = UIColor.tabBarBackground
        tabBar.tintColor = UIColor.white
        tabBar.unselectedItemTintColor = UIColor.init(white: 1, alpha: 0.5)
        tabBar.isHidden = false
        tabBar.isTranslucent = false
        viewControllers = [homeTab, cardTab]
    }
    
    func setNavigationItem(viewController: UIViewController) {
        let logoImage = UIImage.prographyLogo
        viewController.navigationItem.titleView = UIImageView(image: logoImage)
    }
    
}
