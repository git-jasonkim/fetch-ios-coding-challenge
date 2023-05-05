//
//  Endpoint.swift
//  fetch
//
//  Created by Jason Kim on 5/5/23.
//

import Foundation

enum Endpoint {
    case getMealsByCategory(name: String)
    case getMealDetails(id: String)
}

extension Endpoint {
    enum MethodType: Equatable {
        case GET
        case POST(data: Data?)
    }
}

extension Endpoint {
    
    var host: String { "themealdb.com" }
    
    var version: String {
        switch self {
        default:
            return "/api/json/v1/1"
        }
    }
    
    var path: String {
        switch self {
        case .getMealsByCategory:
            return version + "/filter.php"
        case .getMealDetails:
            return version + "/lookup.php"
        }
    }
    
    var methodType: MethodType {
        switch self {
        case .getMealsByCategory,
             .getMealDetails:
            return .GET
        }
    }
    
    var queryItems: [String: String]? {
        switch self {
        case .getMealsByCategory(let name):
            return ["c":"\(name)"]
        case .getMealDetails(let id):
            return ["i":"\(id)"]
        }
    }
}

extension Endpoint {
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        var requestQueryItems = [URLQueryItem]()
        
        queryItems?.forEach { item in
            requestQueryItems.append(URLQueryItem(name: item.key, value: item.value))
        }
        
        urlComponents.queryItems = requestQueryItems
        
        return urlComponents.url
    }
}
