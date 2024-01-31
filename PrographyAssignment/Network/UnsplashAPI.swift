//
//  UnsplashAPI.swift
//  PrographyAssignment
//
//  Created by 김영현 on 1/31/24.
//

import Foundation

final class UnsplashAPI {
    
    static var unsplashUrlComponents: URLComponents = {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.unsplash.com"
        
        return urlComponents
    }()
    
    static func fetchPhotos(pageNum: Int, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var urlComponents = unsplashUrlComponents
        urlComponents.path = "/photos"
        urlComponents.queryItems = [
            URLQueryItem(name: "page", value: String(pageNum)),
            URLQueryItem(name: "per_page", value: "15"),
            URLQueryItem(name: "client_id", value: APIKeys.access.value)
        ]
        
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: completionHandler)
        dataTask.resume()
    }
    
}
