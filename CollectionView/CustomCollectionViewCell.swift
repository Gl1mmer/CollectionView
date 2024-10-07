//
//  CustomCollectionViewCell.swift
//  CollectionView
//
//  Created by Amankeldi Zhetkergen on 07.10.2024.
//

import UIKit

final class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: CustomCollectionViewCell.self)
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "questionmark.circle")
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Default"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 23, weight: .semibold)
        label.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configure(with image: UIImage?, name: String) {
        imageView.image = image
        infoLabel.text = name
        setupUI()
    }
    
    private func setupUI() {
        
        addSubview(imageView)
        addSubview(infoLabel)
        
        let imageViewConstraints = [
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]
        let infoLabelConstraints = [
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            infoLabel.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(infoLabelConstraints)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
