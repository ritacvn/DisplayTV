import SwiftUI

struct SeriesDetailView: View {
    @StateObject var viewModel: SeriesDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let imageUrl = viewModel.series.image?.original, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 300)
                    .cornerRadius(12)
                }
                
                Text(viewModel.series.name)
                    .font(.largeTitle)
                    .bold()
                
                if let schedule = viewModel.series.schedule {
                    Text("Airs on: \(schedule.days.joined(separator: ", ")) at \(schedule.time)")
                        .font(.subheadline)
                }
                
                if let genres = viewModel.series.genres {
                    Text("Genres: \(genres.joined(separator: ", "))")
                        .font(.subheadline)
                }
                
                Text(viewModel.series.summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression) ?? "No summary available")
                    .font(.body)
                
                Button(action: {
                    viewModel.toggleFavorite()
                }) {
                    HStack {
                        Image(systemName: viewModel.isFavorite ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                        Text(viewModel.isFavorite ? "Remove from Favorites" : "Add to Favorites")
                    }
                }
                .padding()
                
                Text("Episodes by Season")
                    .font(.title2)
                    .bold()
                
                ForEach(viewModel.episodes.keys.sorted(), id: \ .self) { season in
                    VStack(alignment: .leading) {
                        Text("Season \(season)")
                            .font(.headline)
                            .padding(.top, 10)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 16) {
                                ForEach(viewModel.episodes[season] ?? [], id: \ .id) { episode in
                                    NavigationLink(destination: EpisodeDetailView(episode: episode)) {
                                        VStack {
                                            AsyncImage(url: URL(string: episode.image?.medium ?? "")) { image in
                                                image.resizable()
                                                    .scaledToFit()
                                                    .frame(width: 120, height: 160)
                                                    .cornerRadius(8)
                                            } placeholder: {
                                                Color.gray.frame(width: 120, height: 160).cornerRadius(8)
                                            }
                                            
                                            Text(episode.name)
                                                .font(.caption)
                                                .frame(width: 120)
                                                .multilineTextAlignment(.center)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchEpisodes()
        }
    }
}
