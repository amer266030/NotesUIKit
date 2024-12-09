//
//  Note.swift
//  Notes
//
//  Created by Amer Alyusuf on 06/12/2024.
//

import Foundation

struct Note: Identifiable, Equatable, Codable {
    var id: String
    var title: String
    var body: String
    var category: NoteCategory
    var createdAt: Date
    var updatedAt: Date

    init(id: String = UUID().uuidString, title: String, body: String, category: NoteCategory, createdAt: Date = Date(), updatedAt: Date = Date()) {
        self.id = id
        self.title = title
        self.body = body
        self.category = category
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    static func == (lhs: Note, rhs: Note) -> Bool {
        lhs.id == rhs.id
    }

    enum CodingKeys: String, CodingKey {
        case id, title, body, category, createdAt, updatedAt
    }
}
