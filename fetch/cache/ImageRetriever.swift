//
//  ImageRetriever.swift
//  fetch
//
//  Created by Jason Kim on 5/5/23.
//

import Foundation

struct ImageRetriever {
    func fetch(_ imgUrl: String) async throws -> Data {
        guard let url = URL(string: imgUrl) else {
            throw RetrieverError.invalidUrl
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}

private extension ImageRetriever {
    enum RetrieverError: Error {
        case invalidUrl
    }
}
