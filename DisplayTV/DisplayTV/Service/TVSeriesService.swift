import SwiftUI

class TVSeriesService {
    func fetchTVSeries(page: Int, completion: @escaping (Result<[TVSeries], TVSeriesError>) -> Void) {
        let urlString = SeriesEndpoints.shows(page: page)
        fetch(urlString, completion: completion)
    }
    
    func searchSeries(query: String, completion: @escaping (Result<[TVSeries], TVSeriesError>) -> Void) {
        let urlString = SeriesEndpoints.search(query: query)
        fetch(urlString) { (result: Result<[SearchResult], TVSeriesError>) in
            switch result {
            case .success(let searchResults):
                completion(.success(searchResults.map { $0.show }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchEpisodes(showID: Int, completion: @escaping (Result<[Episode], TVSeriesError>) -> Void) {
        let urlString = SeriesEndpoints.episodes(showID: showID)
        fetch(urlString, completion: completion)
    }
    
    private func fetch<T: Decodable>(_ urlString: String, completion: @escaping (Result<T, TVSeriesError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.serverError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
