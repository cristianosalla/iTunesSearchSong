//
//  ClientAPIProtocol.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 14/04/26.
//

import Foundation

public protocol ClientAPIProtocol: Sendable {
    func request<T: Decodable>(url: URL) async throws -> T
}

