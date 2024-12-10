//
//  HomeVM.swift
//  NotesUIKit
//
//  Created by Amer Alyusuf on 08/12/2024.
//

import Foundation

class HomeVM {
    private let dbMgr = DBMgr.shared
    
    var notes: Observable<[Note]> = Observable([])
    var showDrawer = false
    var isLoading: Observable<Bool> = Observable(false)
    var showAlert: Observable<Bool> = Observable(false)
    var alertTitle: String = "Error"
    var alertMsg: String = ""
    
    var filteredNotes: [(NoteCategory, [Note])] {
        Dictionary(grouping: notes.value!, by: { $0.category })
            .map { ($0.key, $0.value) }
            .sorted { $0.0.sortPriority < $1.0.sortPriority }
    }
    
    // MARK: - DB Functions
    
    func initializeApp() async {
        do {
            isLoading.value = true
            try await DBMgr.shared.connectToDB()
            isLoading.value = false
        } catch let error {
            isLoading.value = false
            alertMsg = error.localizedDescription
            showAlert.value = true
        }
    }
    
    func fetchNotes() {
        isLoading.value = true
        do {
            notes.value = try dbMgr.notesTable.fetch()
            isLoading.value = false
        } catch let error {
            alertMsg = error.localizedDescription
            showAlert.value = true
        }
    }
    
    func delete(_ note: Note) {
        isLoading.value = true
        do {
            try dbMgr.notesTable.delete(note)
            isLoading.value = false
        } catch let error {
            alertMsg = error.localizedDescription
            isLoading.value = false
            showAlert.value = true
        }
    }
    
    // MARK: - Table Functions
    
    func numSections() -> Int {
        NoteCategory.allCases.count
    }
    
    func titleForSection(in section: Int) -> String? {
        guard section < filteredNotes.count else { return nil }
        return filteredNotes[section].0.rawValue
    }
    
    func numOfRowsInSection(in section: Int) -> Int {
        guard section < filteredNotes.count else { return 0 }
        return filteredNotes[section].1.count
    }
    
}
