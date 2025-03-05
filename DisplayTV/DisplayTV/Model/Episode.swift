struct Episode: Codable, Identifiable {
    let id: Int
    let name: String
    let season: Int
    let number: Int
    let summary: String?
    let image: ImageInfo?
}
