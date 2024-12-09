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
        
        self.tableView.estimatedRowHeight = 48
        self.tableView.rowHeight = UITableView.automaticDimension
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
}
