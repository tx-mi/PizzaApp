//
//  FiltersView.swift
//  PizzaApp
//
//  Created by Ramazan Abdulaev on 14.10.2022.
//

import UIKit

class FiltersView: UICollectionReusableView {
    
    static let id = "FiltersId"
    static let kind = "Filters"
    
    var didUpdateSegment: ((Int) -> Void)?
    var selectedIndex: Int = 0 {
        didSet {
            segmentedControll.selectedSegmentIndex = selectedIndex
        }
    }
    
    private lazy var segmentedControll: CustomSegmentedControl = {
        let items = [
            "Pizzas",
            "Burgers",
            "Desserts",
            "Drinks"
        ]
        let sc = CustomSegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        sc.selectedSegmentTintColor = .transparentPink
        sc.backgroundColor = .clear
        sc.layer.borderColor = UIColor.clear.cgColor
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        segmentedControll.addTarget(self, action: #selector(valueChanged(_: )), for: .valueChanged)
        makeConstrains()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        segmentedControll.layer.cornerRadius = 20
//        segmentedControll.subviews[2].backgroundColor = .clear
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func valueChanged(_ sender: UISegmentedControl) {
        didUpdateSegment?(sender.selectedSegmentIndex)
    }
    
    private func makeConstrains() {
        addSubview(segmentedControll)
        NSLayoutConstraint.activate([
            segmentedControll.leadingAnchor.constraint(equalTo: leadingAnchor),
            segmentedControll.trailingAnchor.constraint(equalTo: trailingAnchor),
            segmentedControll.topAnchor.constraint(equalTo: topAnchor),
            segmentedControll.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1)
            
        ])
    }

}
