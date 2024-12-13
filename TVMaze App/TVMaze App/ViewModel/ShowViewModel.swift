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
    @Published var isAuthenticated: Bool = false
    @Published var pinIsSet: Bool = false
    
    private var apiClient: APIProtocol
    
    init(apiClient: APIProtocol = API()) {
        self.apiClient = apiClient
        self.checkForExistingPIN()
    }
    
    func checkForExistingPIN() {
        if KeychainHelper.load(key: KeychainKeys.userPIN.rawValue) == nil {
            pinIsSet = false
        } else {
            pinIsSet = true
        }
    }
    
    func fetchShows(page: Int) async {
        do {
            let newShows = try await apiClient.fetchShows(page: page)
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
            let searchedShows = try await apiClient.searchShows(query: query)
            
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
