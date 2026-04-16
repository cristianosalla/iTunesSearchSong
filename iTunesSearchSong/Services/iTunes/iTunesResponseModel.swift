//
//  iTunesModels.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 10/04/26.
//

import Foundation

struct iTunesResponse: Decodable {
    let resultCount: Int
    let results: [iTunesResult]
}

enum iTunesResult: Decodable {
    case album(Album)
    case track(Track)
    
    enum CodingKeys: String, CodingKey {
        case wrapperType
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .wrapperType)
        
        switch type {
        case "collection":
            self = .album(try Album(from: decoder))
        case "track":
            self = .track(try Track(from: decoder))
        default:
            throw AppError.wrapperFailed
        }
    }
}
