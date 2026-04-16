//
//  Router.swift
//  iTunesSearchSong
//
//  Created by Cristiano Lunardi on 12/04/26.
//

import SwiftUI

@Observable
class Router {
    var path = NavigationPath()
    
    func navigate(to route: Route) {
        path.append(route)
    }
    
    func goBack() {
        path.removeLast()
    }
}

enum Route: Hashable {
    case player(Int)
    case album(Track)
}
