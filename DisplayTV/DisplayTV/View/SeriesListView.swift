//
//  ContentView.swift
//  DisplayTV
//
//  Created by Rita Vasconcelos on 04/03/25.
//

import SwiftUI

struct SeriesListView: View {
    @State private var series: [TVSeries] = []
    
    var body: some View {
        NavigationView {
            List(series) { show in
                HStack {
                    AsyncImage(url: URL(string: show.image?.medium ?? "")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 80, height: 120)
                    .cornerRadius(8)
                    
                    VStack(alignment: .leading) {
                        Text(show.name)
                            .font(.headline)
                        Text(show.summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression) ?? "No summary available")
                            .font(.subheadline)
                            .lineLimit(3)
                    }
                }
            }
            .navigationTitle("TV Shows")
            .onAppear {
                fetchTVSeries()
            }
        }
    }
    
    func fetchTVSeries() {
        guard let url = URL(string: "https://api.tvmaze.com/shows") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([TVSeries].self, from: data)
                    DispatchQueue.main.async {
                        self.series = decodedResponse
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}

