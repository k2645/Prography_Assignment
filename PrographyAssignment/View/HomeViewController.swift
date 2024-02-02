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
    
    private lazy var dataSource: PhotosDataSource = PhotosDataSource(
        collectionView: photoCollectionView) { [weak self] (collectionView, indexPath, photoCellContents) in
            guard let cell = self?.photoCollectionView.dequeueReusableCell(
                withReuseIdentifier: PhotoCollectionViewCell.identifier,
                for: indexPath
            ) as? PhotoCollectionViewCell else {
                return PhotoCollectionViewCell()
            }
            cell.configureCell(photoCellContents: photoCellContents)
            
            return cell
        }
    
    private lazy var photoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [photoLabel, photoCollectionView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let photoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "최신 이미지"
        label.textColor = .black
        label.font = UIFont.pretendard(size: 20, weight: .bold)
        
        return label
    }()
    
    private lazy var photoCollectionView: UICollectionView = {
        let layout = createCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private let viewModel: HomeViewModel
    private let disposeBag = DisposeBag()
    
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
        updatePhotos()
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
    
    func updatePhotos() {
        viewModel.fetchPhotos()
    }
    
    func bind() {
        viewModel.cellContentsOutput
            .observe(on: MainScheduler())
            .subscribe { [weak self] content in
                var snapshot = NSDiffableDataSourceSnapshot<Section, PhotoCellContents>()
                snapshot.appendSections([.Photos])
                snapshot.appendItems(content, toSection: Section.Photos)
                self?.dataSource.apply(snapshot)
            }
            .disposed(by: disposeBag)
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    
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
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
}
