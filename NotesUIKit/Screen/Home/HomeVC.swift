//
//  HomeVC.swift
//  NotesUIKit
//
//  Created by Amer Alyusuf on 08/12/2024.
//

import UIKit

class HomeVC: UIViewController {
    var vm = HomeVM()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Home"
        self.view.backgroundColor = UIColor.background
        let leadingButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: self, action: #selector(vm.editButtonTapped))
        
        self.navigationItem.leftBarButtonItem = leadingButton
        // Do any additional setup after loading the view.
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
