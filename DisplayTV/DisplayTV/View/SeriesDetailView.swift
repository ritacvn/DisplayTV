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
                
                Text("Episodes by Season")
                    .font(.title2)
                    .bold()
                
                ForEach(viewModel.episodes.keys.sorted(), id: \ .self) { season in
                    Section(header: Text("Season \(season)")) {
                        ForEach(viewModel.episodes[season] ?? [], id: \ .id) { episode in
                            Text(episode.name)
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
