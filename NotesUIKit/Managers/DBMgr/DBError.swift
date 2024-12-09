//
//  DBError.swift
//  Notes
//
//  Created by Amer Alyusuf on 07/12/2024.
//

import Foundation

enum DBError: Error {
    case connection
    case decodingError(Error)
    case tableOperationError
}

extension DBError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .connection:
            return "Connection Error"
        case .decodingError(let error):
            return "Decoding Error: \(error.localizedDescription)"
        case .tableOperationError:
            return "Error Modifying DB table"
        }
    }
}
