//
//  APICaller.swift
//  AvitoTrainee
//
//  Created by Артур Байбиков on 30.08.2023.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case networkError
    case unknownError
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return NSLocalizedString("Decode Error", comment: "")
        case .networkError:
            return NSLocalizedString("Network Error", comment: "")
        case .unknownError:
            return NSLocalizedString("Unknown Error", comment: "")
        }
    }
}

final class APICaller {
    private let urlSession = URLSession.shared //Singleton usage
    
    func performRequest<T: Codable>(request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let task = urlSession.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let model = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(model))
                    } catch {
                        completion(.failure(.decodingError))
                    }
                } else if error != nil {
                    completion(.failure(.networkError))
                } else {
                    completion(.failure(.unknownError))
                }
            }
        }
        task.resume()
    }
}


