//
//  Validations.swift
//  Notes
//
//  Created by Amer Alyusuf on 08/12/2024.
//

import Foundation

enum ValidationError: Error {
    case emptyField(String)
}

extension ValidationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .emptyField(let fieldName):
            return "\(fieldName) field cannot be empty"
        }
    }
}
