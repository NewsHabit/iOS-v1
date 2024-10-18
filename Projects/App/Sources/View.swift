//
//  View.swift
//  newshabit
//
//  Created by 지연 on 10/19/24.
//

import UIKit

class View: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemPink.withAlphaComponent(0.1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
