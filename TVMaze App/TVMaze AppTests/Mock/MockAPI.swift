//
//  MockAPI.swift
//  TVMaze AppTests
//
//  Created by Mathias Nonohay on 13/12/24.
//

import Foundation
@testable import TVMaze_App

enum MockError: Error {
    case genericError
}

class MockAPI: APIProtocol {
    func fetchShows(page: Int) async throws -> [Show] {
        if page == 1 {
            [
                Show(id: 1, name: "Mock Show 1", image: nil, schedule: Schedule(days: ["Monday"], time: "8:00 PM"), genres: ["Drama"], summary: "Summary 1", _embedded: nil),
                Show(id: 2, name: "Mock Show 2", image: nil, schedule: Schedule(days: ["Tuesday"], time: "9:00 PM"), genres: ["Comedy"], summary: "Summary 2", _embedded: nil)
            ]
        } else {
            throw MockError.genericError
        }
    }
    
    func searchShows(query: String) async throws -> [Show] {
        if query.lowercased() == "mock" {
            return [Show(id: 1, name: "Mock Show 1", image: nil, schedule: Schedule(days: ["Monday"], time: "8:00 PM"), genres: ["Drama"], summary: "Summary 1", _embedded: nil)]
        } else {
            return []
        }
    }
    
    func fetchShowEpisodes(id: Int) async throws -> Show {
        if id == 1 {
            return Show(id: 1, 
                        name: "Mock Show 1",
                        image: nil,
                        schedule: Schedule(days: ["Monday"], time: "8:00 PM"),
                        genres: ["Drama"],
                        summary: "Summary 1",
                        _embedded: Embedded(episodes: [Episode(id: 1,
                                                               name: "Pilot",
                                                               season: 1,
                                                               number: 1,
                                                               summary: "Summary Episode",
                                                               image: nil)]))
        } else {
            throw MockError.genericError
        }
    }
}
