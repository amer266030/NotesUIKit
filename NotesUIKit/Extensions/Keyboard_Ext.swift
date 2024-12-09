//
//  Keyboard_Ext.swift
//  Notes
//
//  Created by Amer Alyusuf on 07/12/2024.
//

import UIKit

extension UIScreen {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
