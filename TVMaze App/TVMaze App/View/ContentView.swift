//
//  ContentView.swift
//  TVMaze App
//
//  Created by Mathias Nonohay on 12/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ShowViewModel()
    @State private var searchText = ""
    @State private var currentPage = 0
    
    var body: some View {
        if viewModel.pinIsSet && viewModel.isAuthenticated {
            NavigationView {
                VStack {
                    if viewModel.shows.isEmpty {
                        ProgressView()
                    } else {
                        showList
                    }
                }
                .searchable(text: $searchText)
                .onChange(of: searchText) { _ , newValue in
                    if newValue.isEmpty {
                        viewModel.shows.removeAll()
                        currentPage = 0
                        Task { await viewModel.fetchShows(page: currentPage) }
                    } else {
                        viewModel.shows.removeAll()
                        Task { await viewModel.searchShows(query: newValue) }
                    }
                }
                .navigationTitle("TV Shows")
                .task {
                    if viewModel.shows.isEmpty {
                        await viewModel.fetchShows(page: 0)
                    }
                }
            }
        } else {
            SetPinView(isPinSet: $viewModel.pinIsSet, isAuthenticated: $viewModel.isAuthenticated)
        }
    }
    
    @ViewBuilder
    private var showList: some View {
        List(viewModel.shows) { show in
            NavigationLink(destination: ShowDetailView(show: show)) {
                HStack {
                    if let imageUrl = show.image?.medium {
                        AsyncImage(url: URL(string: imageUrl)) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    
                    Text(show.name)
                }
            }
            .onAppear {
                if viewModel.shows.last == show {
                    Task { await loadMoreShows() }
                }
            }
        }
    }
    
    private func loadMoreShows() async {
        currentPage += 1
        await viewModel.fetchShows(page: currentPage)
    }
}

#Preview {
    ContentView()
}
