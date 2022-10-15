//
//  MenuCollectionView.swift
//  PizzaApp
//
//  Created by Ramazan Abdulaev on 14.10.2022.
//

import UIKit

final class MenuCollectionView: UICollectionView {
    
    private enum Constants {
        static let sectionOfProducts: Int = 1
        static let numberOfBanners: Int = 2
    }
    
    private var viewModel: MenuViewModelProtocol
    
    init(frame: CGRect, viewModel: MenuViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: frame, collectionViewLayout: MenuCollectionView.configureLayout())
        
        registerCells()
        self.viewModel.getAllProducts()
        self.viewModel.didUpdatesProducts = { [weak self] Products in
            self?.reloadData()
        }
        delegate = self
        dataSource = self
        backgroundColor = .darkWhite
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registerCells() {
        register(
            BannerCell.self,
            forCellWithReuseIdentifier: BannerCell.reuseID
        )
        register(
            ProductCell.self,
            forCellWithReuseIdentifier: ProductCell.reuseID
        )
        register(
            FiltersView.self,
            forSupplementaryViewOfKind: FiltersView.kind,
            withReuseIdentifier: FiltersView.id
        )
    }
    
}

// MARK: - UICollectionViewDelegate

extension MenuCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Constants.numberOfBanners
        default:
            return viewModel.countProducts()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            return setupBanners(indexPath: indexPath)
        default:
            return setupProducts(indexPath: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return setupFiltersSuplementaryView(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true) // TODO: Add modal detail View
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.sectionOfProducts + 1
    }
    
    
    
}

// MARK: - Setup cells and suplemetaryVies

private extension MenuCollectionView {
    
    func setupBanners(indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: BannerCell.reuseID,
                                             for: indexPath) as? BannerCell
        else { return UICollectionViewCell() }
        
        switch indexPath.row {
        case 0:
            cell.configure(image: UIImage(named: "pizzaSaleBanner"))
        default:
            cell.configure(image: UIImage(named: "burgerSaleBanner"))
        }
        
        return cell
    }
    
    func setupProducts(indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: ProductCell.reuseID,
                                             for: indexPath) as? ProductCell
        else { return UICollectionViewCell() }
        cell.backgroundColor = .white
        
        guard
            let product = viewModel.products[0]?.first // TODO: Get correct product
        else { return cell }
        cell.configure(product: product)
        return cell
    }
    
    func setupFiltersSuplementaryView(indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: FiltersView.kind,
            withReuseIdentifier: FiltersView.id,
            for: indexPath
        ) as? FiltersView else { return UICollectionReusableView() }
        // TODO: get correct indexes for scroll
        view.didUpdateSegment = { [weak self] segment in
            let indexToScroll = IndexPath(item: 0, section: Constants.sectionOfProducts)
            self?.scrollToItem(at: indexToScroll,
                               at: .top,
                               animated: true)
        }
        return view
    }
    
}
