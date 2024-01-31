//
//  CardViewController.swift
//  PrographyAssignment
//
//  Created by 김영현 on 1/29/24.
//

import UIKit

final class CardViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setNavigationBarBackground()
    }


}

extension CardViewController {
    
    func setUI() {
        view.backgroundColor = .white
    }
    
    func setNavigationBarBackground() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
}
