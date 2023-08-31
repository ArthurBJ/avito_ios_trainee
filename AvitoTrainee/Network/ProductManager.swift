//
//  NetworkManager.swift
//  AvitoTrainee
//
//  Created by Артур Байбиков on 27.08.2023.
//

import UIKit

protocol ProductManagerProtocol {
    func getAllProducts(completion: @escaping (Result<AllProductResponse, NetworkError>) -> Void)
    func getProduct(id: String, completion: @escaping (Result<ProductDetailData, NetworkError>) -> Void)
}

class ProductManager: ProductManagerProtocol {
    
    struct Constants {
        static let baseUrl = URL(string: "https://www.avito.st/s/interns-ios/main-page.json")
    }
    
    private let network = APICaller()
    
    func getAllProducts(completion: @escaping (Result<AllProductResponse, NetworkError>) -> Void) {
        guard let url = Constants.baseUrl else {
            completion(.failure(.networkError))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        network.performRequest(request: urlRequest, completion: completion)
    }
    
    func getProduct(id: String, completion: @escaping (Result<ProductDetailData, NetworkError>) -> Void) {
        let urlRequest = URLRequest(url: URL(string: "https://www.avito.st/s/interns-ios/details/\(id).json")!)
        network.performRequest(request: urlRequest, completion: completion)
    }
    
}
