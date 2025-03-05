import Foundation

class SeriesListViewModel: ObservableObject {
    @Published var series: [TVSeries] = []
    private var currentPage = 0
    private var isLoading = false
    
    func fetchTVSeries() {
        guard !isLoading else { return }
        isLoading = true
        
        let urlString = "https://api.tvmaze.com/shows?page=\(currentPage)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([TVSeries].self, from: data)
                    DispatchQueue.main.async {
                        self.series.append(contentsOf: decodedResponse)
                        self.currentPage += 1
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
    
    func fetchNextPage() {
        fetchTVSeries()
    }
    
    func searchSeries(query: String) {
        guard !query.isEmpty else {
            series.removeAll()
            currentPage = 0
            fetchTVSeries()
            return
        }
        
        let urlString = "https://api.tvmaze.com/search/shows?q=\(query)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([SearchResult].self, from: data)
                    DispatchQueue.main.async {
                        self.series = decodedResponse.map { $0.show }
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}
