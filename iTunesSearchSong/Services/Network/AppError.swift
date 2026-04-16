//
//  AppError.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 12/04/26.
//

enum AppError: Error {
    case invalidURL
    case albumNotFound
    case wrapperFailed
    case requestError
}
