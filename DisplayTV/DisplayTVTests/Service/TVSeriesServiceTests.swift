import XCTest
@testable import DisplayTV

class TVMazeServiceTests: XCTestCase {
    var service: TvSeriesServiceMock!
    
    override func setUp() {
        super.setUp()
        service = TvSeriesServiceMock()
    }
    
    func testFetchTVSeries_Success() {
            service.mockSeries = [TVSeries(id: 1, name: "Test Show", image: nil, schedule: nil, genres: nil, summary: nil)]
            
            service.fetchTVSeries(page: 1) { result in
                switch result {
                case .success(let series):
                    XCTAssertEqual(series.count, 1)
                    XCTAssertEqual(series.first?.name, "Test Show")
                case .failure:
                    XCTFail("Expected success, but got failure")
                }
            }
        }
        
        func testFetchTVSeries_Failure() {
            service.shouldReturnError = true
            
            service.fetchTVSeries(page: 1) { result in
                switch result {
                case .success:
                    XCTFail("Expected failure, but got success")
                case .failure(let error):
                    XCTAssertEqual(error.localizedDescription, TVSeriesError.serverError.localizedDescription)
                }
            }
        }
        func testSearchSeries_Success() {
            service.mockSeries = [TVSeries(id: 1, name: "Test Search", image: nil, schedule: nil, genres: nil, summary: nil)]
            
            service.searchSeries(query: "Test") { result in
                switch result {
                case .success(let series):
                    XCTAssertEqual(series.count, 1)
                    XCTAssertEqual(series.first?.name, "Test Search")
                case .failure:
                    XCTFail("Expected success, but got failure")
                }
            }
        }
        
        func testFetchEpisodes_Success() {
            service.mockEpisodes = [Episode(id: 1, name: "Pilot", season: 1, number: 1, summary: nil, image: nil)]
            
            service.fetchEpisodes(showID: 1) { result in
                switch result {
                case .success(let episodes):
                    XCTAssertEqual(episodes.count, 1)
                    XCTAssertEqual(episodes.first?.name, "Pilot")
                case .failure:
                    XCTFail("Expected success, but got failure")
                }
            }
        }
}
