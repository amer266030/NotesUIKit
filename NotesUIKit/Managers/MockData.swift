//
//  MockData.swift
//  Notes
//
//  Created by Amer Alyusuf on 06/12/2024.
//

import Foundation

class MockData {
    static let shared = MockData()
    var notes: [Note] = []
    
    private init() {
        createNotes()
    }
    
    func createNotes() {
        notes = [
            .init(
                title: "Grocery Shopping List",
                body: "Buy milk, eggs, bread, and fruits for the week.",
                category: NoteCategory.Personal
            ),
            .init(
                title: "Daily Journal Entry",
                body: "Today was a good day! I completed my workout and finished reading a new book.",
                category: NoteCategory.Personal
            ),
            .init(
                title: "Project Milestones",
                body: "Finalize UI designs, review backend integration, and prepare for the sprint demo.",
                category: NoteCategory.Work
            ),
            .init(
                title: "Movie Recommendations",
                body: "Inception, The Matrix, and Interstellar are must-watch sci-fi movies.",
                category: NoteCategory.Other
            )
        ]
    } 
}
