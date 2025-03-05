import XCTest
@testable import DisplayTV

// MARK: - Mock TVMazeService
class TvSeriesServiceMock: TVSeriesService {
    var shouldReturnError = false
    var mockSeries: [TVSeries] = []
    var mockEpisodes: [Episode] = []
    
    override func fetchTVSeries(page: Int, completion: @escaping (Result<[TVSeries], TVSeriesError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.serverError))
        } else {
            completion(.success(mockSeries))
        }
    }
    
    override func searchSeries(query: String, completion: @escaping (Result<[TVSeries], TVSeriesError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.serverError))
        } else {
            completion(.success(mockSeries))
        }
    }
    
    override func fetchEpisodes(showID: Int, completion: @escaping (Result<[Episode], TVSeriesError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.serverError))
        } else {
            completion(.success(mockEpisodes))
        }
    }
}
