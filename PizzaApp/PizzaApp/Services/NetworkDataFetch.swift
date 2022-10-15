//
//  NetworkDataFetch.swift
//  PizzaApp
//
//  Created by Ramazan Abdulaev on 15.10.2022.
//

import Foundation



protocol NetworkDataFetchProtocol {
    
    func fetchProducts(completion: @escaping ([Int:[Product]]?) -> Void)
    
}

final class NetworkDataFetch: NetworkDataFetchProtocol {
    
    private var networkService = NetworkService()
    
    func fetchProducts(completion: @escaping ([Int:[Product]]?) -> Void) {
        var products = [Int:[Product]]()
        var i = 0
        let group = DispatchGroup()

        for category in Categories.allCases {
            group.enter()
            var newProducts: [Product] = []
            self.networkService.request(searchTerm: category.path) { results in
                switch results {
                case .success(let data):
                    newProducts = self.decodeJSON(T: [Product].self, from: data) ?? []
                case .none:
                    print("None")
                case .some(.failure(_)):
                    print("failure")
                }
                products[i] = Array(newProducts.prefix(10))
                i += 1
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(products)
        }
        
    }
    
    private func decodeJSON<T: Decodable>(T: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(T.self, from: data)
            return objects
        } catch let error {
            print("Failed to decode JSON", error)
            return nil
        }
    }
    
}

