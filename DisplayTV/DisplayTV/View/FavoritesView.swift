import SwiftUI

struct FavoritesView: View {
    @Binding var needsUpdate: Bool
    @State private var favorites = FavoritesManager.shared.getFavorites()
    
    var body: some View {
        List(favorites) { show in
            NavigationLink(destination: SeriesDetailView(viewModel: SeriesDetailViewModel(series: show, service: TVSeriesService()))) {
                HStack {
                    AsyncImage(url: URL(string: show.image?.medium ?? "")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 80, height: 120)
                    .cornerRadius(8)
                    
                    Text(show.name)
                        .font(.headline)
                }
            }
        }
        .navigationTitle("Favorites")
        .onAppear {
            favorites = FavoritesManager.shared.getFavorites()
        }
    }
}
