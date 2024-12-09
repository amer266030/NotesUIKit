//
//  NetworkError.swift
//  Notes
//
//  Created by Amer Alyusuf on 08/12/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Could not fetch time from server!"
        }
    }
}
