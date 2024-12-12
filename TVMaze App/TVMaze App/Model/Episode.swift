//
//  Episode.swift
//  TVMaze App
//
//  Created by Mathias Nonohay on 12/12/24.
//

import Foundation

struct Episode: Codable, Identifiable {
    let id: Int
    let name: String
    let season: Int
    let number: Int
    let summary: String
    let image: ImageData?
}
