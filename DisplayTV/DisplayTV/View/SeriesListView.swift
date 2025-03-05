import SwiftUI

struct SeriesListView: View {
    @StateObject var viewModel: SeriesListViewModel
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                List(viewModel.series) { show in
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
                    .onAppear {
                        if show == viewModel.series.last {
                            viewModel.fetchNextPage()
                        }
                    }
                }
                .navigationTitle("TV Shows")
                .onAppear {
                    viewModel.fetchTVSeries()
                }
            }
        }
        .onChange(of: searchText) {
            viewModel.searchSeries(query: searchText)
        }
    }
}
