//
//  ClientAPI.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 12/04/26.
//

import Foundation

final class ClientAPI: ClientAPIProtocol {
    let session = URLSession.shared

    func request<T: Decodable>(url: URL) async throws -> T {
        do {
            let (data, _) = try await session.data(from: url)
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            throw error
        }
    }
}
