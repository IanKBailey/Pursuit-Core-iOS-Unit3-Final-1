//
//  ElementsAPIClient.swift
//  Elements
//
//  Created by Ian Bailey on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct ElementsAPIClient {
static func fetchElements(completion: @escaping (Result <[ElementData], AppError>) ->()) {
    
    let podcastURL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
    
    guard let url = URL(string: podcastURL) else {
        completion(.failure(.badURL(podcastURL)))
        return
    }
    
    let request = URLRequest(url: url)
    
    
    NetworkHelper.shared.performDataTask(with: request) { (result) in
        switch result {
        case .failure(let appError):
            completion(.failure(.networkClientError(appError)))
        case .success(let data):
            do {
                let elementsInfo = try JSONDecoder().decode([ElementData].self, from: data)
                completion(.success(elementsInfo))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
    }
}
}
