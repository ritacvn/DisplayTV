import Foundation

struct TVSeries: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let image: ImageInfo?

    static func == (lhs: TVSeries, rhs: TVSeries) -> Bool {
        return lhs.id == rhs.id
    }
}


struct ImageInfo: Codable {
    let medium: String?
    let original: String?
}
