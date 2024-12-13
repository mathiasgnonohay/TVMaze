//
//  TVMaze_AppTests.swift
//  TVMaze AppTests
//
//  Created by Mathias Nonohay on 12/12/24.
//

import XCTest
@testable import TVMaze_App

final class ShowDetailViewModelTests: XCTestCase {
    
    var viewModel: ShowDetailViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ShowDetailViewModel(apiClient: MockAPI())
    }

    func testFetchEpisodes() async throws {
        let showId = 1
        await viewModel.fetchShowEpisodes(id: showId)
        
        DispatchQueue.main.async {
            XCTAssertFalse(self.viewModel.episodes.isEmpty, "Episodes should not be empty after fetching")
            XCTAssertEqual(self.viewModel.episodes[0].name, "Pilot")
        }
    }
    
    func testFetchInvalidShow() async throws {
        let showId = -1
        await viewModel.fetchShowEpisodes(id: showId)
        
        DispatchQueue.main.async {
            XCTAssertTrue(self.viewModel.episodes.isEmpty)
            XCTAssertEqual(self.viewModel.errorMessage, "The operation couldn’t be completed. (TVMaze_AppTests.MockError error 0.)")
        }
    }
}
