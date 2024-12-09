//
//  NoteCategory.swift
//  Notes
//
//  Created by Amer Alyusuf on 06/12/2024.
//

import SwiftUI

enum NoteCategory: String, Identifiable, CaseIterable, Codable {
    case Work, Personal, Other
    
    var id: String { rawValue }
    
    var sortPriority: Int {
        switch self {
        case .Work:
            1
        case .Personal:
            2
        case .Other:
            3
        }
    }
    
    var img: String {
        switch self {
        case .Work:
            "case"
        case .Personal:
            "person"
        case .Other:
            "circle.dotted"
        }
    }
    
    var color: Color {
        switch self {
        case .Work:
                .indigo
        case .Personal:
                .cyan
        case .Other:
                .orange
        }
    }
    
}
