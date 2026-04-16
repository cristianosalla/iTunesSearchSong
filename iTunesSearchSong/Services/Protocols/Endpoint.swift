//
//  Endpoint.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 12/04/26.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var url: URL? { get }
    var baseURL: String { get }
}
