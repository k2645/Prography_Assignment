//
//  APIKeys.swift
//  PrographyAssignment
//
//  Created by 김영현 on 1/31/24.
//

import Foundation

enum APIKeys: String {
    
    case access
    case secret
    
    var value: String {
        switch self {
        case .access:
            return Bundle.main.object(forInfoDictionaryKey: "UNSPLASH_ACCESS_KEY") as! String
        case .secret:
            return Bundle.main.object(forInfoDictionaryKey: "UNSPLASH_SECRET_KEY") as! String
        }
    }
    
}
