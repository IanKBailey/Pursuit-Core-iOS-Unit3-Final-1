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


    static func postElements(element: FavoriteElements , completion: @escaping (Result<Bool,AppError>) -> ()) {
  
  let endpointURLString = "http://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
  guard let url = URL(string: endpointURLString) else {
    completion(.failure(.badURL(endpointURLString)))
    return
  }
  do {
    let data = try JSONEncoder().encode(element)
    var request = URLRequest(url: url)
    
    request.httpMethod = "POST"
    
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    request.httpBody = data

    NetworkHelper.shared.performDataTask(with: request) { (result) in
      switch result {
      case .failure(let appError):
        completion(.failure(.networkClientError(appError)))
      case .success:
        completion(.success(true))
      }
    }
    
  } catch {
    completion(.failure(.encodingError(error)))
  }
  
}
}
