//
//  ShowDetailView.swift
//  TVMaze App
//
//  Created by Mathias Nonohay on 12/12/24.
//

import SwiftUI

struct ShowDetailView: View {
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
                Text("Genres: \(show.genres.joined(separator: ", "))")
                Text("Summary: \(show.summary)")
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
