//
//  HomeViewModel.swift
//  PrographyAssignment
//
//  Created by 김영현 on 2/1/24.
//

import RxRelay

protocol HomeViewModel: HomeViewModelInput, HomeViewModelOutput {
    
}

protocol HomeViewModelInput {
    
    func fetchPhotos(pageNum: Int)
    
}

protocol HomeViewModelOutput {
    
    var fetchImageContentsOutput: PublishRelay<[PhotoCellContents]> { get }
    
}
