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
    
    private func navigateToAnotherView() {
        hideDrawer()
        let newViewController = AddNoteVC()
        newViewController.title = "Add Note"

        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    private func configureDrawer() {
        overlayView = UIView(frame: view.bounds)
//        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        overlayView.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideDrawer))
        overlayView.addGestureRecognizer(tapGesture)
        view.addSubview(overlayView)
        
        drawerView = DrawerView(frame: CGRect(x: -drawerWidth, y: 0, width: drawerWidth, height: view.bounds.height))
        drawerView.callBack = { [weak self] in
            self?.navigateToAnotherView()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
