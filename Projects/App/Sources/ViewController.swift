//
//  ViewController.swift
//  newshabit
//
//  Created by 지연 on 10/18/24.
//

import UIKit

import Shared

class ViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupScrollView()
        addImages()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func addImages() {
        let imageProperties: [String: UIImage] = [
            "back": Images.back,
            "bookmarkActive": Images.bookmarkActive,
            "bookmarkInactive": Images.bookmarkInactive,
            "checkActive": Images.checkActive,
            "checkInactive": Images.checkInactive,
            "chevronLeft": Images.chevronLeft,
            "chevronRight": Images.chevronRight,
            "empty": Images.empty,
            "error": Images.error,
            "export": Images.export,
            "homeActive": Images.homeActive,
            "homeInactive": Images.homeInactive,
            "logoBelt": Images.logoBelt,
            "newsActive": Images.newsActive,
            "newsInactive": Images.newsInactive,
            "refresh": Images.refresh,
            "settingsActive": Images.settingsActive,
            "settingsInactive": Images.settingsInactive
        ]
        
        for (name, image) in imageProperties {
            let containerView = UIView()
            containerView.translatesAutoresizingMaskIntoConstraints = false
            
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            let label = UILabel()
            label.text = name
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            
            containerView.addSubview(imageView)
            containerView.addSubview(label)
            
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
                imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 100),
                imageView.heightAnchor.constraint(equalToConstant: 100),
                
                label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
                label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
            
            stackView.addArrangedSubview(containerView)
        }
    }
}

