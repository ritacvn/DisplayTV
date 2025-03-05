import Foundation

class SeriesListViewModel: ObservableObject {
    @Published var series: [TVSeries] = []
    @Published var showError = false
    @Published var errorMessage = ""
    
    private var currentPage = 0
    private var isLoading = false
    private var lastRequest: (() -> Void)?
    let service: TVSeriesService
    
    init(service: TVSeriesService) {
        self.service = service
    }
    
    func fetchTVSeries() {
        guard !isLoading else { return }
        isLoading = true
        lastRequest = { self.fetchTVSeries() }
        
        service.fetchTVSeries(page: currentPage) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let shows):
                    self.series.append(contentsOf: shows)
                    self.currentPage += 1
                case .failure(let error):
                    self.showError(with: error.localizedDescription)
                }
            }
        }
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
        
        lastRequest = { self.searchSeries(query: query) }
        
        service.searchSeries(query: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let shows):
                    self.series = shows
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
    
    func retryLastRequest() {
        lastRequest?()
    }
}
