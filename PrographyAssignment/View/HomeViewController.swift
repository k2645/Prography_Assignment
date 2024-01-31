//
//  HomeViewController.swift
//  PrographyAssignment
//
//  Created by 김영현 on 1/29/24.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private var pageNum = 0
    private var photos: [Photo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setNavigationBarBackground()
    }

}

private extension HomeViewController {
    
    func setUI() {
        view.backgroundColor = .white
    }
    
    func setNavigationBarBackground() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
//    func fetchPhoto() {
//        UnsplashAPI.fetchPhotos(pageNum: pageNum + 1) { data, response, error in
//            
//            guard let _ = response as? HTTPURLResponse,
//                  let data = data else { return }
//            do {
//                let fetchedPhotos = try JSONDecoder().decode([Photo].self, from: data)
//                print(fetchedPhotos)
//            } catch {
//                print(error)
//            }
//        }
//    }
    
}
