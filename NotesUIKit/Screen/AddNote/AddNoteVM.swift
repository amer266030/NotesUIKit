//
//  AddNoteVM.swift
//  NotesUIKit
//
//  Created by Amer Alyusuf on 09/12/2024.
//

import Foundation

class AddNoteVM {
    private let dbMgr = DBMgr.shared
    var note = Note(title: "", body: "", category: NoteCategory.Other)
    var isUpdate = false
    var serverTime: ServerTime?
    var isLoading: Observable<Bool> = Observable(false)
    var showAlert: Observable<Bool> = Observable(false)
    var alertTitle: String = "Error"
    var alertMsg: String = ""
    
    init(_ note: Note? = nil) {
        if let note {
            self.note = note
            isUpdate = true
        }
    }
    
    func fetchTime() async throws -> Date? {
        let serverTime: ServerTime = try await NetworkManager.getRequest(urlString: NetworkManager.baseURL)
        guard let date = serverTime.datetime?.toDateFromISOString() else {
            throw NetworkError.invalidResponse
        }
        return date
    }
    
    func updateNoteAttributes(title: String, body: String, category: NoteCategory) {
        note.title = title
        note.body = body
        note.category = category
    }
    
    func saveNote() async -> Bool {
        isLoading.value = true
        do {
            try validateNote()
            
            guard let date = try await fetchTime() else { throw NetworkError.invalidResponse }
            note.updatedAt = date
            if isUpdate {
                try dbMgr.notesTable.update(note)
            } else {
                note.createdAt = date
                try dbMgr.notesTable.insert(note)
            }
            isLoading.value = false
            return true
        } catch let error {
            isLoading.value = false
            alertMsg = error.localizedDescription
            showAlert.value = true
            return false
        }
    }
    
    func validateNote() throws {
        if note.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw ValidationError.emptyField("Title")
        }
        if note.body.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw ValidationError.emptyField("Body")
        }
    }
}
