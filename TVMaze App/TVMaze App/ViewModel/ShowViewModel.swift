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
        guard shows.isEmpty else { return }
        
        do {
            let newShows = try await API.fetchShows(page: page)
            DispatchQueue.main.async { [weak self] in
                self?.shows.append(contentsOf: newShows)
            }
        } catch {
            DispatchQueue.main.async { [weak self] in
                self?.errorMessage = error.localizedDescription
            }
        }
    }
    
    func searchShows(query: String) async {
        do {
            let searchedShows = try await API.searchShows(query: query)
            DispatchQueue.main.async { [weak self] in
                self?.shows = searchedShows
            }
        } catch {
            DispatchQueue.main.async { [weak self] in
                self?.errorMessage = error.localizedDescription
            }
        }
    }
}
