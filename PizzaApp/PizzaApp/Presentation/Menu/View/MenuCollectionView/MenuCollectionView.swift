//
//  MenuCollectionView.swift
//  PizzaApp
//
//  Created by Ramazan Abdulaev on 14.10.2022.
//

import UIKit

class MenuCollectionView: UICollectionView {

    private let viewModel: MenuViewModelProtocol
    
    init(frame: CGRect, viewModel: MenuViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: frame, collectionViewLayout: MenuCollectionView.configureLayout())
        
        registerCells()
        delegate = self
        dataSource = self
        backgroundColor = .darkWhite
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registerCells() {
        register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.reuseID)
        register(FilterCell.self, forCellWithReuseIdentifier: FilterCell.reuseID)
        register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseID)
    }
    
}

// MARK: - UICollectionViewDelegate

extension MenuCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 2 {
            return 5
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            return setupBanners(indexPath: indexPath)
        case 1:
            return setupFilters(indexPath: indexPath)
        default:
            return setupProducts(indexPath: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
}

// MARK: - Setup cells and suplemetaryVies

private extension MenuCollectionView {
    
    func setupBanners(indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: BannerCell.reuseID,
                                             for: indexPath) as? BannerCell
        else { return UICollectionViewCell() }
        cell.backgroundColor = .red
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func setupFilters(indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: FilterCell.reuseID,
                                             for: indexPath) as? FilterCell
        else { return UICollectionViewCell() }
        cell.layer.borderColor = UIColor.transparentPink.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 18
        return cell
    }
    
    func setupProducts(indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: ProductCell.reuseID,
                                             for: indexPath) as? ProductCell
        else { return UICollectionViewCell() }
        cell.backgroundColor = .white
        if indexPath.row == 0 {
            cell.roundCorners(corners: [.topLeft, .topRight], radius: 16)
        }
        return cell
    }
}
