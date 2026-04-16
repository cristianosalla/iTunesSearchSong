//
//  Endpoint.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 12/04/26.
//

import Foundation

struct iTunesEndpoint: Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
    let baseURL = "https://itunes.apple.com"
    
    var url: URL? {
        var components = URLComponents(string: "\(baseURL)\(path)")
        components?.queryItems = queryItems
        return components?.url
    }

    static func search(term: String, entity: String = "song", limit: Int = 40) -> iTunesEndpoint {
        iTunesEndpoint(
            path: "/search",
            queryItems: [
                URLQueryItem(name: "term", value: term),
                URLQueryItem(name: "entity", value: entity),
                URLQueryItem(name: "limit", value: "\(limit)")
            ]
        )
    }
    
    static func album(collectionId: Int) -> iTunesEndpoint {
        iTunesEndpoint(
            path: "/lookup",
            queryItems: [
                URLQueryItem(name: "id", value: "\(collectionId)"),
                URLQueryItem(name: "entity", value: "song")
            ]
        )
    }
}

