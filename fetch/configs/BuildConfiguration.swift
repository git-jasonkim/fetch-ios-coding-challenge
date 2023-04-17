//
//  BuildConfiguration.swift
//  fetch
//
//  Created by J a s o n K i m on 4/12/23.
//

import Foundation


class BuildConfiguration {

    enum Environment: String {
        case dev = "Debug"
        case prod = "Release"
    }
    
    static let shared = BuildConfiguration()
    public var environment: Environment
    
    init() {
        guard
            let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String,
            let environment = Environment(rawValue: currentConfiguration)
        else {
            fatalError("Configuration is nil")
        }
        self.environment = environment
    }

    public var baseURL: String {
        return host + version
    }
    
    private var host: String {
        switch environment {
        case .dev:
            return API.Host.dev
        case .prod:
            return API.Host.prod
        }
    }
    
    private var version: String {
        switch environment {
        case .dev:
            return API.Version.V1
        case .prod:
            return API.Version.V1
        }
    }

}
