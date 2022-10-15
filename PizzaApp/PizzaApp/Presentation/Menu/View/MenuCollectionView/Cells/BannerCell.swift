//
//  BannerCell.swift
//  PizzaApp
//
//  Created by Ramazan Abdulaev on 14.10.2022.
//

import UIKit

class BannerCell: UICollectionViewCell {
    
    static let reuseID = "BannerCellID"
    
    private lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        bannerImageView.image = nil
    }
    
    private func makeConstraints() {
        addSubview(bannerImageView)
        NSLayoutConstraint.activate([
            bannerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bannerImageView.topAnchor.constraint(equalTo: topAnchor),
            bannerImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}

extension BannerCell {
    
    func configure(image: UIImage?) {
        self.bannerImageView.image = image
    }
}
