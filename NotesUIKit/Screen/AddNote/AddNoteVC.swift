//
//  AddNoteVC.swift
//  NotesUIKit
//
//  Created by Amer Alyusuf on 09/12/2024.
//

import UIKit

class AddNoteVC: UIViewController {
    
    var vm: AddNoteVM?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var segmentedPicker: UISegmentedControl!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    @IBOutlet weak var createdAtLabel: UILabel!
    
    @IBOutlet weak var updatedAtLabel: UILabel!
    
    @IBOutlet weak var createBtnView: UIButton!
    
    @IBAction func createBtnAction(_ sender: UIButton) {
        Task {
            guard let vm = vm else { return }
            vm.updateNoteAttributes(
                title: titleTextField.text ?? "",
                body: bodyTextView.text ?? "",
                category: NoteCategory.allCases[segmentedPicker.selectedSegmentIndex]
            )
            let result = await vm.saveNote()
            if result == true {
                if let navigationController = navigationController {
                    navigationController.popViewController(animated: true)
                } else {
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.background
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            view.addGestureRecognizer(tapGesture)
        
        if let vm = vm {
            configureView(vm: vm)
        }
        bindViewModel()
    }
    
    @objc private func handleTap() {
        dismissKeyboard()
    }
    
    func bindViewModel() {
        guard let vm = vm else { return }
        
        vm.isLoading.bind { [weak self] isLoading in
            guard let self = self else { return }
            guard let isLoading = isLoading else { return }
            
            DispatchQueue.main.async {
                if isLoading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        
        vm.showAlert.bind { [weak self] showAlert in
            guard let self = self else { return }
            guard let showAlert = showAlert else { return }
            
            DispatchQueue.main.async {
                if showAlert {
                    let alertTitle = vm.alertTitle
                    let alertMsg = vm.alertMsg
                    
                    let alertController = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                        vm.showAlert.value = false
                    })
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    vm.showAlert.value = false
                }
            }
        }
    }
    
    func configureView(vm: AddNoteVM) {
        self.vm = vm
        
        guard isViewLoaded else { return }
        
        segmentedPicker.removeAllSegments()
        for (index, category) in NoteCategory.allCases.enumerated() {
            segmentedPicker.insertSegment(withTitle: category.rawValue, at: index, animated: false)
        }
        
        if let selectedIndex = NoteCategory.allCases.firstIndex(where: { $0 == vm.note.category }) {
            segmentedPicker.selectedSegmentIndex = selectedIndex
        } else {
            segmentedPicker.selectedSegmentIndex = UISegmentedControl.noSegment
        }
        
        titleTextField.text = vm.note.title
        bodyTextView.text = vm.note.body
        createBtnView.setTitle(vm.isUpdate ?  "Update" : "Create", for: .normal)
        createdAtLabel.text = vm.note.createdAt.formatted(date: .abbreviated, time: .shortened)
        updatedAtLabel.text = vm.note.updatedAt.formatted(date: .abbreviated, time: .shortened)
    }
    
}
