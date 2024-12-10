//
//  DrawerVC.swift
//  NotesUIKit
//
//  Created by Amer Alyusuf on 09/12/2024.
//

import UIKit

class DrawerView: UIView {
    private let navigateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Note", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var callBack: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        self.backgroundColor = .white

        // Add the button
        addSubview(navigateButton)
        navigateButton.addTarget(self, action: #selector(navigateButtonTapped), for: .touchUpInside)

        // Set constraints for the button
        NSLayoutConstraint.activate([
            navigateButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            navigateButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            navigateButton.widthAnchor.constraint(equalToConstant: 150),
            navigateButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func navigateButtonTapped() {
        callBack?()
    }
}
