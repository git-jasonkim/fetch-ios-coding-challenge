//
//  API+Enum.swift
//  fetch
//
//  Created by Jason Kim on 4/12/23.
//

import Foundation

enum API {
    private static var baseUrl: String {
        return BuildConfiguration.shared.baseURL
    }
    
    public enum Host {
        static let dev = "https://themealdb.com/"
        static let prod = "https://themealdb.com/"
    }
    
    public enum Version {
        static let V1 = "api/json/v1/\(Secret.APIKey)/"
    }
    
    public enum Path {
        static let getMealsByCategory = { (category: String) in
            return baseUrl + "filter.php?c=\(category)"
        }
        static let getMealDetailsById = { (id: String) in
            return baseUrl + "lookup.php?i=\(id)"
        }
    }
    
}
