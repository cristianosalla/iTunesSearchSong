//
//  MockClientObjectResponse.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 14/04/26.
//

import Foundation
@testable import iTunesSearchSong

class MockClientObjectResponse: ClientAPIProtocol, @unchecked Sendable {
    
    var response: Any
    
    init(response: Any) {
        self.response = response
    }
    
    func request<T>(url: URL) async throws -> T where T : Decodable {
        guard let response = response as? T else { throw AppError.requestError }
        return response
    }
}
