//
//  DataMgr.swift
//  Notes
//
//  Created by Amer Alyusuf on 07/12/2024.
//

import Foundation
import SQLite

class DBMgr {
    static let shared = DBMgr()

    private var connection: Connection?

    private(set) lazy var notesTable = NotesTable(connection: connection)

    private init() {
    }
    
    func connectToDB() async throws {
        do {
            let fileManager = FileManager.default
            let documentsURL = try fileManager.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            let dbPath = documentsURL.appendingPathComponent("notesTable.sqlite3").path
            connection = try Connection(dbPath)
        } catch {
            throw DBError.connection
        }
    }
}
