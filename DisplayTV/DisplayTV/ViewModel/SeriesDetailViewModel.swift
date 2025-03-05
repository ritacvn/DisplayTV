import Foundation

class SeriesDetailViewModel: ObservableObject {
    @Published var series: TVSeries
    @Published var episodes: [Int: [Episode]] = [:]
    @Published var showError = false
    @Published var errorMessage = ""
    
    private let service: TVSeriesService
    
    init(series: TVSeries, service: TVSeriesService) {
        self.series = series
        self.service = service
    }
    
    func fetchEpisodes() {
        service.fetchEpisodes(showID: series.id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let episodes):
                    self.episodes = Dictionary(grouping: episodes, by: { $0.season })
                case .failure(let error):
                    self.showError(with: error.localizedDescription)
                }
            }
        }
    }
    
    private func showError(with message: String) {
        DispatchQueue.main.async {
            self.errorMessage = message
            self.showError = true
        }
    }
}
