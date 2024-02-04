//
//  HomeViewController.swift
//  PrographyAssignment
//
//  Created by 김영현 on 1/29/24.
//

import UIKit
import RxSwift

final class HomeViewController: UIViewController {
    
    typealias PhotosDataSource = UICollectionViewDiffableDataSource<Section, PhotoCellContents>
    
    enum Section {
        case Photos
    }
    
    private lazy var dataSource = createDataSource()
    
    private lazy var photoCollectionView: UICollectionView = {
        let layout = createCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier
        )
        collectionView.register(
            PhotoHeaderCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: PhotoHeaderCell.identifier
        )
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private let viewModel: HomeViewModel
    private let disposeBag = DisposeBag()
    private var pageNum = 0
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setNavigationBarBackground()
        addComponents()
        addConstraints()
        fetchPhotos()
        bind()
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
    
    func addComponents() {
        view.addSubview(photoCollectionView)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            photoCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            photoCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            photoCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
}

private extension HomeViewController {
    
    func fetchPhotos() {
        viewModel.fetchPhotos(pageNum: 0)
    }
    
    func bind() {
        viewModel.fetchImageContentsOutput
            .observe(on: MainScheduler())
            .subscribe { [weak self] content in
                guard let self = self else { return }
                if pageNum == 0 {
                    var snapshot = NSDiffableDataSourceSnapshot<Section, PhotoCellContents>()
                    snapshot.appendSections([.Photos])
                    snapshot.appendItems(content, toSection: Section.Photos)
                    dataSource.apply(snapshot)
                } else {
                    var snapshot = dataSource.snapshot()
                    snapshot.appendItems(content, toSection: Section.Photos)
                    dataSource.apply(snapshot)
                    photoCollectionView.refreshControl?.endRefreshing()
                }
            }
            .disposed(by: disposeBag)
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    
    func createDataSource() -> PhotosDataSource {
        let dataSource = PhotosDataSource(
            collectionView: photoCollectionView) { (collectionView, indexPath, photoCellContents) in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: PhotoCollectionViewCell.identifier,
                    for: indexPath
                ) as? PhotoCollectionViewCell else {
                    return PhotoCollectionViewCell()
                }
                cell.configureCell(photoCellContents: photoCellContents)
                
                return cell
            }
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            return collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: PhotoHeaderCell.identifier,
                for: indexPath
            ) as? PhotoHeaderCell
        }
        
        return dataSource
    }
        
    func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(200)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .estimated(200)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: 2
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = CGFloat(10)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(46))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        if maximumOffset < currentOffset {
            pageNum += 1
            viewModel.fetchPhotos(pageNum: pageNum)
        }
    }
    
}
