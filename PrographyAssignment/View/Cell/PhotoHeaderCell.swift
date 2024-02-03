//
//  PhotoHeaderCell.swift
//  PrographyAssignment
//
//  Created by 김영현 on 2/3/24.
//

import UIKit

final class PhotoHeaderCell: UICollectionReusableView {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private let photoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "최신 이미지"
        label.textColor = .black
        label.font = UIFont.pretendard(size: 20, weight: .bold)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
        addComponents()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension PhotoHeaderCell {
    
    func setUI() {
        backgroundColor = .clear
    }
    
    func addComponents() {
        addSubview(photoLabel)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            photoLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            photoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }
    
}
