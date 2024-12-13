//
//  ShowDetailView.swift
//  TVMaze App
//
//  Created by Mathias Nonohay on 12/12/24.
//

import SwiftUI

struct ShowDetailView: View {
    @StateObject private var viewModel = ShowDetailViewModel()
    let show: Show
    
    var body: some View {
        ScrollView {
            VStack {
                if let imageUrl = show.image?.original {
                    AsyncImage(url: URL(string: imageUrl)) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(height: 300)
                    } placeholder: {
                        ProgressView()
                    }
                }
                Text(show.name)
                    .font(.largeTitle)
                    .padding()
                Text("Airs \(show.schedule.days.joined(separator: ", ")) at \(show.schedule.time)")
                    .padding()
                Text("Genres: \(show.genres.joined(separator: ", "))")
                    .padding()
                Text("Summary: \(show.summary.htmlToString())")
                    .padding()
                
                if !viewModel.episodes.isEmpty {
                    episodesView(episodes: viewModel.episodes)
                } else {
                    ProgressView("Loading Episodes")
                        .task {
                            await viewModel.fetchShowEpisodes(id: show.id)
                        }
                }
            }.padding()
        }
        .navigationTitle(show.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    func episodesView(episodes: [Episode]) -> some View {
        let episodesBySeason = Dictionary(grouping: episodes, by: { $0.season })
        let sortedSeason = episodesBySeason.keys.sorted()
        
        Group {
            ForEach(sortedSeason, id: \.self) { season in
                Section(header: Text("Season \(season)")) {
                    ForEach(episodesBySeason[season] ?? [], id: \.id) { episode in
                        NavigationLink(destination: EpisodeDetailView(episode: episode)) {
                            HStack {
                                Text(episode.name)
                                Spacer()
                                Text("Episode \(episode.number)")
                                    .foregroundStyle(.gray)
                            }
                            .padding(2)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ShowDetailView(show: Show(id: 1,
                              name: "Movie 1",
                              image: nil,
                              schedule: Schedule(days: ["day"], time: "11:00"),
                              genres: ["Action"],
                              summary: "Action Movie",
                              _embedded: nil))
}
