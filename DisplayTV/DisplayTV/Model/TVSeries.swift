import Foundation

struct TVSeries: Identifiable, Codable {
    let id: Int
    let name: String
    let image: ImageInfo?
    let summary: String?
}

struct ImageInfo: Codable {
    let medium: String?
    let original: String?
}
