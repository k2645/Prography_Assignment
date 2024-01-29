//
//  TabBarController.swift
//  PrographyAssignment
//
//  Created by 김영현 on 1/29/24.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeTab = HomeViewController()
        homeTab.tabBarItem = UITabBarItem(title: nil, image: UIImage.house, selectedImage: UIImage.house)
        let cardTab = CardViewController()
        cardTab.tabBarItem = UITabBarItem(title: nil, image: UIImage.cards, selectedImage: UIImage.cards)
        
        self.viewControllers = [homeTab, cardTab]
    }
    
}
