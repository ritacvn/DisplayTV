import Foundation

class SeriesListViewModel: ObservableObject {
    @Published var series: [TVSeries] = []
    
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
