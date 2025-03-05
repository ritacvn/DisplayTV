//
//  TVSeriesError.swift
//  DisplayTV
//
//  Created by Rita Vasconcelos on 04/03/25.
//

import Foundation

enum TVSeriesError: Error, LocalizedError {
    case invalidURL
    case networkError(Error)
    case serverError
    case noData
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .networkError(let error):
            return error.localizedDescription
        case .serverError:
            return "Server error: Unexpected response."
        case .noData:
            return "No data received."
        case .decodingError:
            return "Failed to decode data."
        }
    }
}
