//
//  UnsplashDTO.swift
//  PrographyAssignment
//
//  Created by 김영현 on 1/31/24.
//

import Foundation

struct Photo: Codable, Hashable {

    let identifier: String
    let height: Int
    let width: Int
    let color: String
    let description: String?
    let user: User
    let urls: URLKind
    let links: LinkKind
    
    var imageRatio: CGFloat {
        return CGFloat(height) / CGFloat(width)
    }

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case height
        case width
        case color
        case description
        case user
        case urls
        case links
    }
    
    struct URLKind: Codable, Hashable {
        let raw: String
        let full: String
        let regular: String
        let small: String
        let thumb: String
    }

    struct LinkKind: Codable, Hashable {
        let own: String
        let html: String
        let download: String
        let downloadLocation: String
        
        enum CodingKeys: String, CodingKey {
            case html
            case download
            case own = "self"
            case downloadLocation = "download_location"
        }
    }
    
    struct User: Codable, Hashable {
        let name: String
    }
    
}
