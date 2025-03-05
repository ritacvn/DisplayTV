import XCTest
@testable import DisplayTV

class SeriesDetailViewModelTests: XCTestCase {
    var viewModel: SeriesDetailViewModel!
    var service: TvSeriesServiceMock!
    
    override func setUp() {
        super.setUp()
        service = TvSeriesServiceMock()
        let testSeries = TVSeries(id: 1, name: "Test Show", image: nil, schedule: nil, genres: nil, summary: nil)
        viewModel = SeriesDetailViewModel(series: testSeries, service: service)
    }
    
    func testFetchEpisodes_Success() {
        service.mockEpisodes = [Episode(id: 1, name: "Pilot", season: 1, number: 1, summary: nil, image: nil)]
        let expectation = expectation(description: "Fetch Episodes Success")
        
        viewModel.fetchEpisodes()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            XCTAssertEqual(self.viewModel.episodes.count, 1)
            XCTAssertEqual(self.viewModel.episodes[1]?.first?.name, "Pilot")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
    }
    
    func testFetchEpisodes_Failure() {
        service.shouldReturnError = true
        let expectation = expectation(description: "Fetch Episodes Failure")
        
        viewModel.fetchEpisodes()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            XCTAssertTrue(self.viewModel.showError)
            XCTAssertEqual(self.viewModel.errorMessage, "Server error: Unexpected response.")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
    }
}
