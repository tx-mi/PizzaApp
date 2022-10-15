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
    
    private lazy var segmentedControll: UISegmentedControl = {
        let items = ["Pizzas", "Burgers", "Combo", "Water"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentTintColor = .transparentPink
        sc.backgroundColor = .none
        sc.layer.borderColor = .none
        sc.layer.cornerRadius = 20
        sc.selectedSegmentIndex = 0
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    let wow = "wow"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        segmentedControll.addTarget(self, action: #selector(valueChanged(_: )), for: .valueChanged)
        makeConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
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
            segmentedControll.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
            
        ])
    }

}
