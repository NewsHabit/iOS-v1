//
//  ViewController.swift
//  newshabit
//
//  Created by 지연 on 10/18/24.
//

import UIKit

import Shared

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        
        let labels: [UILabel] = [
            createLabel(text: "Heading 1", font: Fonts.heading1),
            createLabel(text: "Heading 2", font: Fonts.heading2),
            createLabel(text: "Heading 3", font: Fonts.heading3),
            createLabel(text: "Title 1", font: Fonts.title1),
            createLabel(text: "Title 2", font: Fonts.title2),
            createLabel(text: "Title 3", font: Fonts.title3),
            createLabel(text: "Body 1", font: Fonts.body1),
            createLabel(text: "Body 2", font: Fonts.body2),
            createLabel(text: "Body 3", font: Fonts.body3),
            createLabel(text: "Caption 1", font: Fonts.caption1),
            createLabel(text: "Caption 2", font: Fonts.caption2)
        ]
        
        let stackView = UIStackView(arrangedSubviews: labels)
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        
        view.addSubview(stackView)
        
        // Add constraints
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func createLabel(text: String, font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = Colors.gray09
        label.numberOfLines = 1
        return label
    }
}

