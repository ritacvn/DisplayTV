//
//  SeriesEndpoints.swift
//  DisplayTV
//
//  Created by Rita Vasconcelos on 04/03/25.
//

import Foundation

struct SeriesEndpoints {
    static let baseURL = "https://api.tvmaze.com"
    static func shows(page: Int) -> String { "\(baseURL)/shows?page=\(page)" }
    static func search(query: String) -> String { "\(baseURL)/search/shows?q=\(query)" }
    static func episodes(showID: Int) -> String { "\(baseURL)/shows/\(showID)/episodes" }
}
