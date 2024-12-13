//
//  EpisodeDetailView.swift
//  TVMaze App
//
//  Created by Mathias Nonohay on 12/12/24.
//

import SwiftUI

struct EpisodeDetailView: View {
    let episode: Episode
    
    var body: some View {
        ScrollView {
            VStack {
                if let imageUrl = episode.image?.original {
                    AsyncImage(url: URL(string: imageUrl)) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(height: 300)
                    } placeholder: {
                        ProgressView()
                    }
                }
                Text(episode.name)
                    .font(.largeTitle)
                    .padding()
                
                Text("Season \(episode.season), Episode \(episode.number)")
                    .foregroundStyle(.gray)
                Text("Summary: \(episode.summary.htmlToString())")
                    .padding()
            }
        }
        .navigationTitle(episode.name)
    }
}

#Preview {
    EpisodeDetailView(episode: Episode(id: 1,
                                       name: "Pilot",
                                       season: 1,
                                       number: 1,
                                       summary: "First Episode",
                                       image: nil))
}
