//
//  HomeVC.swift
//  NotesUIKit
//
//  Created by Amer Alyusuf on 08/12/2024.
//

import UIKit

class HomeVC: UIViewController {
    var vm = HomeVM()

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var navlLeadingButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewLayout()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        vm.fetchNotes()
    }
    
    func bindViewModel() {
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
        
        vm.notes.bind { [weak self] notes in
            guard let self = self else { return }
            self.reloadTableView()
        }
    }

    func configureViewLayout() {
        self.title = "Home"
        self.view.backgroundColor = UIColor.background
        
        configureNavbarButton()
        configureHeaderLabel()
        configureTableView()
    }
    
    func configureNavbarButton() {
        navlLeadingButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: self, action: #selector(vm.editButtonTapped))
        navlLeadingButton.tintColor = UIColor.text
        self.navigationItem.leftBarButtonItem = navlLeadingButton
    }
    
    func configureHeaderLabel() {
        let preferredFont = UIFont.preferredFont(forTextStyle: .title1)
        let descriptor = preferredFont.fontDescriptor.withSymbolicTraits(.traitBold)
        headerLabel.font = UIFont(descriptor: descriptor!, size: preferredFont.pointSize)
    }
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
