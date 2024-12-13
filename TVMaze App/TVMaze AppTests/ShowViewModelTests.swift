//
//  ShowViewModelTests.swift
//  TVMaze AppTests
//
//  Created by Mathias Nonohay on 13/12/24.
//

import XCTest
@testable import TVMaze_App

final class ShowViewModelTests: XCTestCase {
    
    var viewModel: ShowViewModel!
    
    override func setUp() {
        super.setUp()
        
        viewModel = ShowViewModel(apiClient: MockAPI())
    }
    
    override func tearDown() {
        KeychainHelper.delete(key: KeychainKeys.userPIN.rawValue)
        super.tearDown()
    }

    func testCheckForExistingPIN_WhenPINExists() {
        let pin = "1234"
        
        KeychainHelper.save(key: KeychainKeys.userPIN.rawValue, data: pin)
        
        viewModel.checkForExistingPIN()
        
        XCTAssertTrue(viewModel.pinIsSet, "pinIsSet should be true when a PIN exists")
    }
    
    func testCheckForExistingPIN_WhenPINDoesNotExist() {
        KeychainHelper.delete(key: KeychainKeys.userPIN.rawValue)
        
        viewModel.checkForExistingPIN()
        
        XCTAssertFalse(viewModel.pinIsSet, "pinIsSet should be false when a PIN does not exists")
    }
    
    func testFetchShows() async throws {
        await viewModel.fetchShows(page: 1)
        
        DispatchQueue.main.async {
            XCTAssertFalse(self.viewModel.shows.isEmpty, "Show should not be empty after fetching.")
            XCTAssertEqual(self.viewModel.shows.count, 2, "Should return 2 mock shows")
        }
    }
    
    func testSearchShows() async throws {
        await viewModel.searchShows(query: "mock")
        
        DispatchQueue.main.async {
            XCTAssertFalse(self.viewModel.shows.isEmpty, "Shows should not be empty after searching")
            XCTAssertEqual(self.viewModel.shows.count, 1, "Should return 1 mock show fot the search query")
        }
    }
    
    func testSearchShows_NoResults() async throws {
        await viewModel.searchShows(query: "nonexistent")
        
        XCTAssertTrue(viewModel.shows.isEmpty, "Shows should be empty for a nonexistent search query")
    }
}
