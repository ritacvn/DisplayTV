import SwiftUI

struct SeriesListView: View {
    @StateObject var viewModel: SeriesListViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.series) { show in
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
                viewModel.fetchTVSeries()
            }
        }
    }
}
