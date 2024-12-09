//
//  UIView_Ext.swift
//  NotesUIKit
//
//  Created by Amer Alyusuf on 09/12/2024.
//

import UIKit

extension UIView {
    func cornerRadius(_ radius: CGFloat = 8) {
        layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func addBorder(color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}
