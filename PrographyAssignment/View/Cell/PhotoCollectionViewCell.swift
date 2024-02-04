//
//  PhotoCollectionViewCell.swift
//  PrographyAssignment
//
//  Created by 김영현 on 1/31/24.
//

import UIKit
import Kingfisher

final class PhotoCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private lazy var photoImageViewHeight = photoImageView.heightAnchor.constraint(equalToConstant: 0)
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let gradientView: UIView = {
        let view = UIView()
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.black.withAlphaComponent(0), UIColor.black.withAlphaComponent(0.3)]
        view.layer.addSublayer(gradient)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.pretendard(size: 13, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 2
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addComponents()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configureCell(photoCellContents: PhotoCellContents) {
        title.text = photoCellContents.title
        photoImageViewHeight.constant = contentView.frame.width * photoCellContents.imageRatio
        photoImageView.kf.setImage(with: photoCellContents.imageURL)
    }
    
}

private extension PhotoCollectionViewCell {
    
    func addComponents() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(title)
        photoImageView.addSubview(gradientView)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageViewHeight
        ])
        
        NSLayoutConstraint.activate([
            gradientView.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor),
            gradientView.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            title.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -8),
            title.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: -7.5)
        ])
    }
    
}
