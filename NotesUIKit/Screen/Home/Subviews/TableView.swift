//
//  NotesTable.swift
//  NotesUIKit
//
//  Created by Amer Alyusuf on 09/12/2024.
//

import Foundation
import UIKit

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.backgroundColor = .clear
        
        registerCells()
    }
    
    func reloadTableView() {
        self.tableView.reloadData()
    }
    
    func registerCells() {
        tableView.register(NoteCell.register(), forCellReuseIdentifier: NoteCell.identifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return vm.numSections()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return vm.titleForSection(in: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.numOfRowsInSection(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.identifier, for: indexPath) as? NoteCell else {
            return UITableViewCell()
        }
        let notesInSection = vm.filteredNotes[indexPath.section].1
        let note = notesInSection[indexPath.row]
        cell.setupCell(vm: NoteCellVM(note: note))
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Get the note for the selected section and row
        let notesInSection = vm.filteredNotes[indexPath.section].1
        let note = notesInSection[indexPath.row]
        
        // Edit action
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] _, _, completionHandler in
            guard let self = self else { return }
            let editViewController = AddNoteVC()
            editViewController.title = "Edit Note"
            editViewController.vm = AddNoteVM(note) // Pass the note to edit
            self.navigationController?.pushViewController(editViewController, animated: true)
            completionHandler(true)
        }
        editAction.backgroundColor = .blue
        
        // Delete action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completionHandler in
            guard let self = self else { return }
            self.vm.delete(note)
            
            // Update filtered notes and reload the table view
            self.vm.notes.value = self.vm.notes.value?.filter { $0 != note }
            tableView.reloadData()
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        
        // Combine actions
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}
