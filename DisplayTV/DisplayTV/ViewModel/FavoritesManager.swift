import SwiftUI

class FavoritesManager {
    static let shared = FavoritesManager()
    let favoritesKey = "favoriteSeries"
    
    private init() {}
    
    func saveFavorite(series: TVSeries) {
        var favorites = getFavorites()
        if !favorites.contains(where: { $0.id == series.id }) {
            favorites.append(series)
            saveFavorites(favorites)
        }
    }
    
    func removeFavorite(series: TVSeries) {
        var favorites = getFavorites()
        favorites.removeAll { $0.id == series.id }
        saveFavorites(favorites)
    }
    
    func getFavorites() -> [TVSeries] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey),
              let favorites = try? JSONDecoder().decode([TVSeries].self, from: data) else {
            return []
        }
        return favorites.sorted { $0.name < $1.name }
    }
    
    private func saveFavorites(_ favorites: [TVSeries]) {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: favoritesKey)
        }
    }
}
