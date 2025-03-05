import Foundation

struct TVSeries: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let image: ImageInfo?
    let schedule: Schedule?
    let genres: [String]?
    let summary: String?

    static func == (lhs: TVSeries, rhs: TVSeries) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Schedule: Codable {
    let time: String
    let days: [String]
}

struct ImageInfo: Codable {
    let medium: String?
    let original: String?
}
