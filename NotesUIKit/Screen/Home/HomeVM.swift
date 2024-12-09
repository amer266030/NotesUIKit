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
    
    var filteredNotes: [(NoteCategory, [Note])] {
        Dictionary(grouping: notes.value!, by: { $0.category })
            .map { ($0.key, $0.value) }
            .sorted { $0.0.sortPriority < $1.0.sortPriority }
    }
    
    // MARK: - Data Functions
    
    func fetchNotes() {
        isLoading.value = true
        notes.value = MockData.shared.notes
        isLoading.value = false
    }
    
//    func filterNotesByCategory(_ category: NoteCategory) -> [Note] {
//        notes.value!.filter({$0.category == category})
//    }
    
    // MARK: - Button Functions
    
    func drawerButtonTapped() {
        print("Edit button tapped")
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
