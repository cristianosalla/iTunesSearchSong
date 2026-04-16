//
//  iTunesAPI.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 09/04/26.
//

import Foundation

final class iTunesAPI: Sendable {
    let client: ClientAPIProtocol

    init(client: ClientAPIProtocol = ClientAPI()) {
        self.client = client
    }
}
