//
//  NoteTable.swift
//  Notes
//
//  Created by Amer Alyusuf on 07/12/2024.
//

import SQLite
import Foundation

class NotesTable {
    var db: Connection?

    private let notesTable = Table("note")
    
    private let id = SQLite.Expression<String>("id")
    private let title = SQLite.Expression<String>("title")
    private let body = SQLite.Expression<String>("body")
    private let category = SQLite.Expression<String>("category")
    private let createdAt = SQLite.Expression<String>("created_at")
    private let updatedAt = SQLite.Expression<String>("updated_at")

    init(connection: Connection?) {
        self.db = connection
        try? createTableIfNeeded()
    }

    private func createTableIfNeeded() throws {
        do {
            guard let db else { throw DBError.connection }
            let statement = notesTable.create(ifNotExists: true) { t in
                t.column(id, primaryKey: true)
                t.column(title)
                t.column(body)
                t.column(category)
                t.column(createdAt)
                t.column(updatedAt)
            }
            try db.run(statement)
        } catch {
            throw DBError.tableOperationError
        }
    }

    // MARK: - CRUD Operations

    func fetch() throws -> [Note] {
        var notes: [Note] = []
        do {
            guard let db else { throw DBError.connection }
            for row in try db.prepare(notesTable) {
                if let note = parseRow(row) {
                    notes.append(note)
                }
            }
        } catch {
            throw DBError.tableOperationError
        }
        return notes
    }

    func insert(_ note: Note) throws {
        do {
            guard let db else { throw DBError.connection }
            try db.run(notesTable.insert(
                id <- note.id,
                title <- note.title,
                body <- note.body,
                category <- note.category.rawValue,
                createdAt <- note.createdAt.toISOString(),
                updatedAt <- note.updatedAt.toISOString()
            ))
        } catch {
            throw DBError.tableOperationError
        }
    }

    func update(_ note: Note) throws {
        let target = notesTable.filter(id == note.id)
        do {
            guard let db else { throw DBError.connection }
            try db.run(target.update(
                title <- note.title,
                body <- note.body,
                category <- note.category.rawValue,
                updatedAt <- note.updatedAt.toISOString()
            ))
        } catch {
            throw DBError.tableOperationError
        }
    }

    func delete(_ note: Note) throws {
        let target = notesTable.filter(id == note.id)
        do {
            guard let db else { throw DBError.connection }
            try db.run(target.delete())
        } catch {
            throw DBError.tableOperationError
        }
    }

    // MARK: - Helper

    private func parseRow(_ row: Row) -> Note? {
        guard
            let idValue = try? row.get(id),
            let titleValue = try? row.get(title),
            let bodyValue = try? row.get(body),
            let categoryValue = try? row.get(category),
            let createdAtValue = try? row.get(createdAt),
            let updatedAtValue = try? row.get(updatedAt),
            let createdAtDate = createdAtValue.toDateFromISOString(),
            let updatedAtDate = updatedAtValue.toDateFromISOString(),
            let categoryEnum = NoteCategory(rawValue: categoryValue)
        else {
            return nil
        }
        return Note(
            id: idValue,
            title: titleValue,
            body: bodyValue,
            category: categoryEnum,
            createdAt: createdAtDate,
            updatedAt: updatedAtDate
        )
    }
}

