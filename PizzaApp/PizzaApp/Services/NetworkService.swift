//
//  NetworkService.swift
//  PizzaApp
//
//  Created by Ramazan Abdulaev on 15.10.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func request(searchTerm: String, completion: @escaping (Result<Data, Error>?) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
        
    func request(searchTerm: String, completion: @escaping (Result<Data, Error>?) -> Void) {
        let url = self.url(searchTerm: searchTerm)
        var request = URLRequest(url: url)
        request.httpMethod = "get"
        let task = createDataTask(with: request, completion: completion)
        task.resume()
    }

    private func url(searchTerm: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "ig-food-menus.herokuapp.com"
        components.path = "/\(searchTerm)"
        return components.url!
    }
    
    
    private func createDataTask(with request: URLRequest, completion: @escaping (Result<Data, Error>?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                // Check for Error
                if let error = error {
                    print(error)
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else { return }
                completion(.success(data))
            }
        }
    }
}
