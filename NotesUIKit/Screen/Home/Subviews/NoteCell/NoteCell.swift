//
//  NoteCell.swift
//  NotesUIKit
//
//  Created by Amer Alyusuf on 09/12/2024.
//

import UIKit

class NoteCell: UITableViewCell {
    
    public static var identifier: String {
        get { "NoteCell" }
    }
    
    public static func register() -> UINib {
        UINib(nibName: "NoteCell", bundle: nil)
    }
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }
    
    func configureLayout() {
        backView.cornerRadius()
    }
    
    func setupCell(vm: NoteCellVM) {
        let img = UIImage(systemName: vm.note.category.img)
        let configuration = UIImage.SymbolConfiguration(pointSize: 12, weight: .medium)
        imageView?.image = img?.applyingSymbolConfiguration(configuration)
        
//        print(vm.note.title)
        
        titleLabel.text = vm.note.title
        titleLabel.textColor = UIColor.red
        dateLabel.text = vm.note.updatedAt.formatted(date: .abbreviated, time: .shortened)
    }
}
