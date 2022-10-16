//
//  ProductCell.swift
//  PizzaApp
//
//  Created by Ramazan Abdulaev on 14.10.2022.
//

import UIKit
import SDWebImage

class ProductCell: UICollectionViewCell {
    
    static let reuseID = "ProductCellID"
    
    var photoUrl: String? {
            didSet {
                guard let imageUrl = photoUrl,
                      let url = URL(string: imageUrl)
                else { return }
                foodImageView.sd_setImage(with: url,
                                          placeholderImage: UIImage(systemName: "questionmark.app"))
            }
        }
    
    private lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceButton: UIButton = {
        let button = UIButton()
        button.setTitle("от 345 р", for: .normal)
        button.setTitleColor(.darkPink, for: .normal)
        button.backgroundColor = nil
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.darkPink.cgColor
        button.layer.cornerRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        descriptionLabel.sizeToFit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        foodImageView.image = nil
    }
    
    private func makeConstraints() {
        addSubview(foodImageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(priceButton)
        NSLayoutConstraint.activate([
            foodImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            foodImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            foodImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            foodImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),

            nameLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            
            priceButton.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            priceButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            priceButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.24),
            priceButton.heightAnchor.constraint(equalTo: priceButton.widthAnchor, multiplier: 0.35),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            descriptionLabel.bottomAnchor.constraint(equalTo: priceButton.topAnchor, constant: -8)
        ])
        
        nameLabel.setContentHuggingPriority(.required, for: .vertical)
        descriptionLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
}
//
extension ProductCell {
    
    func configure(product: Product) {
        self.descriptionLabel.text = product.dsc
        self.nameLabel.text = product.name
        self.photoUrl = product.img
    }
}
