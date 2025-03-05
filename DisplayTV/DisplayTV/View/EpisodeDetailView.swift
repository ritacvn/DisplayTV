import SwiftUI

struct EpisodeDetailView: View {
    let episode: Episode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let imageUrl = episode.image?.original, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 300)
                    .cornerRadius(12)
                }
                
                Text(episode.name)
                    .font(.largeTitle)
                    .bold()
                
                Text("Season \(episode.season), Episode \(episode.number)")
                    .font(.subheadline)
                
                Text(episode.summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression) ?? "No summary available")
                    .font(.body)
            }
            .padding()
        }
    }
}
