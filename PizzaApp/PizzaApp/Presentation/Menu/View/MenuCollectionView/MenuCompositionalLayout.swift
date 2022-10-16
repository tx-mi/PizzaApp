//
//  MenuCompositionalLayout.swift
//  PizzaApp
//
//  Created by Ramazan Abdulaev on 14.10.2022.
//

import UIKit

extension MenuCollectionView {
    
    static func configureLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout {
            (sectionIndex, enviroment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                return createBannerLayout()
            default:
                return createProductLayout(sectionIndex: sectionIndex)
            }
        }
    }
    
    static func createBannerLayout() -> NSCollectionLayoutSection? {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .fractionalHeight(1.0)))
        item.contentInsets.leading = 16
        item.contentInsets.trailing = 16
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(0.85),
                              heightDimension: .fractionalHeight(0.20)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.top = 16
        section.contentInsets.bottom = 16
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    static func createProductLayout(sectionIndex: Int) -> NSCollectionLayoutSection? {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .fractionalHeight(1.0)))
        item.contentInsets.bottom = 1
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .fractionalHeight(0.25)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .fractionalHeight(0.07)),
            elementKind: FiltersView.kind,
            alignment: .top
        )
        header.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [
            header
        ]
        section.orthogonalScrollingBehavior = .none
        return section
    }
    
}
