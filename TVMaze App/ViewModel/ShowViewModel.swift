//
//  ShowViewModel.swift
//  TVMaze App
//
//  Created by Mathias Nonohay on 12/12/24.
//

import Foundation

class ShowViewModel: ObservableObject {
    @Published var shows: [Show] = []
    @Published var errorMessage: String?
    
    func fetchShows(page: Int) async {
        do {
            let shows = try await API.fetchShows(page: page)
            DispatchQueue.main.async { [weak self] in
                self?.shows = shows
            }
        } catch {
            DispatchQueue.main.async { [weak self] in
                self?.errorMessage = error.localizedDescription
            }
        }
    }
    
    func searchShows(query: String) async {
        do {
            let shows = try await API.searchShows(query: query)
            DispatchQueue.main.async { [weak self] in
                self?.shows = shows
            }
        } catch {
            DispatchQueue.main.async { [weak self] in
                self?.errorMessage = error.localizedDescription
            }
        }
    }
}
