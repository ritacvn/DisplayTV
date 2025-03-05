import Foundation

class SeriesDetailViewModel: ObservableObject {
    @Published var series: TVSeries
    @Published var episodes: [Int: [Episode]] = [:]
    
    init(series: TVSeries) {
        self.series = series
    }
    
    func fetchEpisodes() {
        let urlString = "https://api.tvmaze.com/shows/\(series.id)/episodes"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedEpisodes = try JSONDecoder().decode([Episode].self, from: data)
                    DispatchQueue.main.async {
                        self.episodes = Dictionary(grouping: decodedEpisodes, by: { $0.season })
                    }
                } catch {
                    print("Error decoding episodes: \(error)")
                }
            }
        }.resume()
    }
}
