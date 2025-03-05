import XCTest
@testable import DisplayTV

class SeriesListViewModelTests: XCTestCase {
    var viewModel: SeriesListViewModel!
    var service: TvSeriesServiceMock!
    
    override func setUp() {
        super.setUp()
        service = TvSeriesServiceMock()
        viewModel = SeriesListViewModel(service: service)
    }
    
    func testFetchTVSeries_Success() {
        service.mockSeries = [TVSeries(id: 1, name: "Test Show", image: nil, schedule: nil, genres: nil, summary: nil)]
        let expectation = expectation(description: "Fetch TV Series Success")
        
        viewModel.fetchTVSeries()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            XCTAssertEqual(self.viewModel.series.count, 1)
            XCTAssertEqual(self.viewModel.series.first?.name, "Test Show")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
    }
    
    func testFetchTVSeries_Failure() {
        service.shouldReturnError = true
        let expectation = expectation(description: "Fetch TV Series Failure")
        
        viewModel.fetchTVSeries()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            XCTAssertTrue(self.viewModel.showError)
            XCTAssertEqual(self.viewModel.errorMessage, "Server error: Unexpected response.")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
    }
}
