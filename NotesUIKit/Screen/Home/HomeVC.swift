//
//  HomeVC.swift
//  NotesUIKit
//
//  Created by Amer Alyusuf on 08/12/2024.
//

import UIKit

class HomeVC: UIViewController {
    var vm = HomeVM()
    private var drawerView: DrawerView!
    private let drawerWidth: CGFloat = UIScreen.main.bounds.width / 2
    private var overlayView: UIView!

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var navlLeadingButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await vm.initializeApp()
            vm.fetchNotes()
        }

        configureViewLayout()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        vm.fetchNotes()
    }
    
    func bindViewModel() {
        vm.notes.bind { [weak self] notes in
            guard let self = self else { return }
            self.reloadTableView()
        }
        
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
                    let alertTitle = self.vm.alertTitle
                    let alertMsg = self.vm.alertMsg
                    
                    let alertController = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                        self.vm.showAlert.value = false
                    })
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    self.vm.showAlert.value = false
                }
            }
        }
    }

    func configureViewLayout() {
        self.title = "Home"
        self.view.backgroundColor = UIColor.background
        
        configureNavbarButton()
        configureHeaderLabel()
        configureTableView()
        configureDrawer()
    }
    
    func configureNavbarButton() {
        navlLeadingButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: self, action: #selector(toggleDrawer))
        navlLeadingButton.tintColor = UIColor.text
        self.navigationItem.leftBarButtonItem = navlLeadingButton
    }
    
    func configureHeaderLabel() {
        let preferredFont = UIFont.preferredFont(forTextStyle: .title1)
        let descriptor = preferredFont.fontDescriptor.withSymbolicTraits(.traitBold)
        headerLabel.font = UIFont(descriptor: descriptor!, size: preferredFont.pointSize)
    }
    
    private func navigateToAddNote() {
        hideDrawer()
        let addNoteVC = AddNoteVC()
        addNoteVC.title = "Add Note"
        addNoteVC.configureView(vm: AddNoteVM())
        navigationController?.pushViewController(addNoteVC, animated: true)
    }
    
    private func configureDrawer() {
        overlayView = UIView(frame: view.bounds)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        overlayView.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideDrawer))
        overlayView.addGestureRecognizer(tapGesture)
        view.addSubview(overlayView)
        
        drawerView = DrawerView(frame: CGRect(x: -drawerWidth, y: 0, width: drawerWidth, height: view.bounds.height))
        drawerView.callBack = { [weak self] in
            self?.navigateToAddNote()
        }
        view.addSubview(drawerView)
    }
    
    @objc private func toggleDrawer() {
        vm.showDrawer.toggle()

        UIView.animate(withDuration: 0.3) {
            self.drawerView.frame.origin.x = self.vm.showDrawer ? 0 : -self.drawerWidth
            self.overlayView.isHidden = !self.vm.showDrawer
            self.overlayView.alpha = self.vm.showDrawer ? 1 : 0
        }
    }
    
    @objc private func hideDrawer() {
        vm.showDrawer = false

        UIView.animate(withDuration: 0.3, animations: {
            self.drawerView.frame.origin.x = -self.drawerWidth
            self.overlayView.alpha = 0
        }) { _ in
            self.overlayView.isHidden = true
        }
    }

}
