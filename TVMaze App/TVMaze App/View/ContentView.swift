//
//  ContentView.swift
//  TVMaze App
//
//  Created by Mathias Nonohay on 12/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ShowViewModel()
    
    var body: some View {
        NavigationView {
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
            }
            .navigationTitle("TV Shows")
            .task {
                await viewModel.fetchShows(page: 0)
            }
        }
    }
}

#Preview {
    ContentView()
}
