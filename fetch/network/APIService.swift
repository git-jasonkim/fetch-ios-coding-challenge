//
//  APIService.swift
//  fetch
//
//  Created by Jason Kim on 4/12/23.
//

import Foundation

class APIService {
    private let session = URLSession.shared
    
    enum HttpMethod {
        static let GET = "GET"
    }
    
    internal func buildRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 60
        return request
    }
    
    // GET request
    internal func get<T: Decodable>(url: URL) async -> Result<T, Error> {
        var request = buildRequest(url: url)
        request.httpMethod = HttpMethod.GET
        
        print("APIController GET request: ", request)
        
        do {
            let (data, response) = try await session.data(for: request)
            print("APIService GET data: ", data)
            print("APIService GET response: ", response)

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw URLError(.badServerResponse)
            }
            
            let result = try JSONDecoder().decode(T.self, from: data)
            return .success(result)
        } catch {
            print("APIService GET error: ", error)
            return .failure(error)
        }
    }
    
    internal func download(url: URL) async -> Result<Data, Error> {
        do {
            let (data, response) = try await session.data(from: url)
            print("APIService download data: ", data)
            print("APIService download response: ", response)

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw URLError(.badServerResponse)
            }
            
            return .success(data)
        } catch {
            print("APIService download error: ", error)
            return .failure(error)
        }
    }
}
