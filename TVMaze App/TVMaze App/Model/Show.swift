//
//  Show.swift
//  TVMaze App
//
//  Created by Mathias Nonohay on 12/12/24.
//

import Foundation

struct Show: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let image: ImageData?
    let schedule: Schedule
    let genres: [String]
    let summary: String
    let _embedded: Embedded?
    
    static func == (lhs: Show, rhs: Show) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name
    }
}

struct ImageData: Codable {
    let medium: String
    let original: String
}

struct Schedule: Codable {
    let days: [String]
    let time: String
}

struct Embedded: Codable {
    let episodes: [Episode]
}

struct SearchResult: Codable {
    let show: Show
}
