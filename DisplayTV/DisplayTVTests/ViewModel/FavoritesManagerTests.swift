import XCTest
@testable import DisplayTV


class FavoritesManagerTests: XCTestCase {
    var manager: FavoritesManager!
    let testSeries = TVSeries(id: 1, name: "Favorite Show", image: nil, schedule: nil, genres: nil, summary: nil)
    
    override func setUp() {
        super.setUp()
        manager = FavoritesManager.shared
        UserDefaults.standard.removeObject(forKey: manager.favoritesKey)
    }
    
    func testSaveFavorite() {
        manager.saveFavorite(series: testSeries)
        let favorites = manager.getFavorites()
        XCTAssertEqual(favorites.count, 1)
        XCTAssertEqual(favorites.first?.name, "Favorite Show")
    }
    
    func testRemoveFavorite() {
        manager.saveFavorite(series: testSeries)
        manager.removeFavorite(series: testSeries)
        let favorites = manager.getFavorites()
        XCTAssertEqual(favorites.count, 0)
    }
    
    func testGetFavoritesSorted() {
        let secondSeries = TVSeries(id: 2, name: "Another Show", image: nil, schedule: nil, genres: nil, summary: nil)
        manager.saveFavorite(series: testSeries)
        manager.saveFavorite(series: secondSeries)
        
        let favorites = manager.getFavorites()
        XCTAssertEqual(favorites.first?.name, "Another Show")
    }
}
