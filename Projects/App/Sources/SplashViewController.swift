//
//  SplashViewController.swift
//  newshabit
//
//  Created by 지연 on 10/21/24.
//

import UIKit

import SnapKit
import Shared

final class SplashViewController: UIViewController {
    // MARK: - Components
    
    private let logoBeltImageView = {
        let imageView = UIImageView()
        imageView.image = Images.logoBelt
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let newsHabitLabel = {
        let label = UILabel()
        label.text = "NewsHabit"
        label.font = Fonts.logo
        label.textColor = Colors.logo
        return label
    }()
    
    private let descriptionLabel = {
        let label = UILabel()
        label.text = "뉴스를 습관처럼"
        label.font = Fonts.title2
        label.textColor = Colors.gray05
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        
        view.addSubview(logoBeltImageView)
        logoBeltImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(newsHabitLabel)
        newsHabitLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(newsHabitLabel.snp.bottom)
        }
    }
}
