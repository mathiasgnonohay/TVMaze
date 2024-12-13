//
//  APIProtocol.swift
//  TVMaze App
//
//  Created by Mathias Nonohay on 13/12/24.
//

import Foundation

protocol APIProtocol {
    func fetchShows(page: Int) async throws -> [Show] 
    func searchShows(query: String) async throws -> [Show]
    func fetchShowEpisodes(id: Int) async throws -> Show
}
