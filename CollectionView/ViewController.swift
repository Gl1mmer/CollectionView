//
//  ViewController.swift
//  CollectionView
//
//  Created by Amankeldi Zhetkergen on 07.10.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    private var spiderMenInfo = [
        [UIImage(named: "tom") : "Tom Holland"],
        [UIImage(named: "tob") : "Tobey Maguire"],
        [UIImage(named: "and") : "Andrew Garfield"]
    ]
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "SPIDER-MEN"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        if let customBoldItalicFont = UIFont(name: "Helvetica-BoldOblique", size: 40) {
                label.font = customBoldItalicFont
            } else {
                label.font = .systemFont(ofSize: 40, weight: .bold)
            }
        return label
    }()
    
    private let backImageView: UIImageView = {
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "wallpaper")
        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()
    
    private let blurEffectView: UIVisualEffectView = {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blur.translatesAutoresizingMaskIntoConstraints = false
        return blur
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundUI()
        setupUI()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupBackgroundUI() {
        
        view.addSubview(backImageView)
        view.addSubview(blurEffectView)
        
        view.sendSubviewToBack(blurEffectView)
        view.sendSubviewToBack(backImageView)
        
        let backImageViewViewConstraints = [
            backImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        let blurEffectViewConstraints = [
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(backImageViewViewConstraints)
        NSLayoutConstraint.activate(blurEffectViewConstraints)
    }
    
    private func setupUI() {
        
        view.addSubview(topLabel)
        view.addSubview(collectionView)
        
        let topLabelConstraints = [
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            topLabel.heightAnchor.constraint(equalToConstant: 50),
        ]
        let collectionViewConstraints = [
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 170),
            collectionView.heightAnchor.constraint(equalToConstant: 480),
        ]
        
        NSLayoutConstraint.activate(collectionViewConstraints)
        NSLayoutConstraint.activate(topLabelConstraints)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spiderMenInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else {
            fatalError("Error ept")
        }
        if let image = spiderMenInfo[indexPath.row].keys.first,
           let name = spiderMenInfo[indexPath.row].values.first {
               cell.configure(with: image, name: name)
           }
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40, height: collectionView.frame.height - 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
