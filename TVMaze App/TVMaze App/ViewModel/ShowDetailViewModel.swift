//
//  ShowDetailViewModel.swift
//  TVMaze App
//
//  Created by Mathias Nonohay on 13/12/24.
//

import Foundation

class ShowDetailViewModel: ObservableObject {
    @Published var episodes: [Episode] = []
    @Published var errorMessage: String?
    
    func fetchShowEpisodes(id: Int) async {
        do {
            let fetchedShow = try await API.fetchShowEpisodes(id: id)
            DispatchQueue.main.async { [weak self] in
                self?.episodes = fetchedShow._embedded?.episodes ?? []
                
            }
        } catch {
            DispatchQueue.main.async { [weak self] in
                self?.errorMessage = error.localizedDescription
                
            }
        }
    }
}
