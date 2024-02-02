//
//  HomeViewModelImpl.swift
//  PrographyAssignment
//
//  Created by 김영현 on 1/31/24.
//

import RxSwift
import RxRelay

final class HomeViewModelImpl: HomeViewModel {
    
    var cellContentsOutput = PublishRelay<[PhotoCellContents]>()
    
    private let disposeBag = DisposeBag()
    
    private var pageNum = 0
    private var photos: [Photo] = []
    
    func fetchPhotos() {
        UnsplashAPI.fetchPhotos(pageNum: pageNum + 1) { [weak self] data, response, error in
            guard let _ = response as? HTTPURLResponse,
                  let data = data else { return }
            
            do {
                var photoCellContents: [PhotoCellContents] = []
                let fetchedPhotos = try JSONDecoder().decode([Photo].self, from: data)
                fetchedPhotos.forEach { [weak self] photo in
                    guard let self = self,
                          let cellData = configureCellData(photo: photo) else { return }
                    photoCellContents.append(cellData)
                }
                self?.cellContentsOutput.accept(photoCellContents)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func configureCellData(photo: Photo) -> PhotoCellContents? {
        guard let url = URL(string: photo.urls.regular) else { return nil }
        
        return PhotoCellContents(title: photo.description, imageURL: url, imageRatio: photo.imageRatio)
    }
    
}
