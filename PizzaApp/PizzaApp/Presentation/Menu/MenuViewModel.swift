//
//  MenuViewModel.swift
//  PizzaApp
//
//  Created by Ramazan Abdulaev on 14.10.2022.
//

import UIKit


protocol MenuViewModelProtocol {
    var products: Products { get }
    var didUpdatesProducts: (((Products)) -> Void)? { get set }
    func countProducts() -> Int
    func getAllProducts()
    func getProduct(at indexPath: IndexPath) -> Product?
}

final class MenuViewModel: MenuViewModelProtocol {
    
    private(set) var products: Products = Products() {
        didSet {
            didUpdatesProducts?(products)
        }
    }
    
    var didUpdatesProducts: (((Products)) -> Void)?
    
    private let network: NetworkDataFetchProtocol
    private(set) var navController: UINavigationController?

    func countProducts() -> Int {
        return products.reduce(0){ $0 + $1.value.count }
    }
    
    init(network: NetworkDataFetchProtocol, navController: UINavigationController?) {
        self.network = network
        self.navController = navController
    }
    
    func getAllProducts() {
        return network.fetchProducts { [weak self] products in
            guard let products,
                  let self
            else { return }
            self.products = products
            
        }
    }
    
    func getProduct(at indexPath: IndexPath) -> Product? {
        var lengthBefore = 0
        for i in 0...3 {
            let currentLength = products[i]?.count ?? 0
            if lengthBefore + currentLength > indexPath.row {
                return products[i]?[indexPath.row - lengthBefore]
            }
            lengthBefore += currentLength
        }
        return products[0]?.first
    }
    
}
