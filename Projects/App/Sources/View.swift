//
//  View.swift
//  newshabit
//
//  Created by 지연 on 10/19/24.
//

import UIKit

import SnapKit
import Shared

class View: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let textField = ValidatableTextField(placeholder: "텍스트", validator: NameValidator())
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerY.equalToSuperview().offset(-100)
        }
        textField.textField.becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
