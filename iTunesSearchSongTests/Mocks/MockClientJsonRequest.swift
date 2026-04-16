//
//  MockClient2.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 14/04/26.
//

import XCTest
@testable import iTunesSearchSong

@MainActor
final class MockClientJsonRequest: ClientAPIProtocol {
    
    var filename: String?
    
    func request<T>(url: URL) async throws -> T where T : Decodable {
        let bundle = Bundle(for: MockClientObjectResponse.self)
        guard let url = bundle.url(forResource: filename, withExtension: "json") else {
            throw AppError.requestError
        }

        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
