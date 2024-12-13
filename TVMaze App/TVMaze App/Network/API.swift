//
//  API.swift
//  TVMaze App
//
//  Created by Mathias Nonohay on 12/12/24.
//

import Foundation

struct API {
    static let baseURL = "https://api.tvmaze.com"
    
    static func fetchShows(page: Int) async throws -> [Show] {
        let url = URL(string: "\(baseURL)/shows?page=\(page)" )!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let shows = try JSONDecoder().decode([Show].self, from: data)
        
        return shows
    }
    
    static func searchShows(query: String) async throws -> [Show] {
        let url = URL(string: "\(baseURL)/search/shows?q=\(query)" )!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let searchResults = try JSONDecoder().decode([SearchResult].self, from: data)
        
        let shows = searchResults.compactMap { $0.show }
        
        return shows
    }
    
    static func fetchShowEpisodes(id: Int) async throws -> Show {
        let url = URL(string: "\(baseURL)/shows/\(id)?embed=episodes")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let show = try JSONDecoder().decode(Show.self, from: data)
        
        return show
    }
}
