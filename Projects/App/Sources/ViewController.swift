//
//  ViewController.swift
//  newshabit
//
//  Created by 지연 on 10/18/24.
//

import UIKit

import Shared
import SnapKit

class ViewController: UIViewController {
    let button = {
        let button = SelectableButton(title: "버튼")
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(56)
            make.center.equalToSuperview()
        }
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped(_ button: UIButton) {
        button.isSelected.toggle()
    }
}

