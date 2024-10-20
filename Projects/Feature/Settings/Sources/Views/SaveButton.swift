//
//  SaveButton.swift
//  FeatureSettings
//
//  Created by 지연 on 10/21/24.
//

import UIKit

import Shared

public final class SaveButton: UIButton {
    public override var isEnabled: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    // MARK: - Init
    
    public init(initialEnabled: Bool = false, title: String = "저장") {
        super.init(frame: .zero)
        
        self.isEnabled = initialEnabled
        setupButton(title: title)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup Methods
    
    private func setupButton(title: String) {
        tintColor = .white
        layer.cornerRadius = 8
        
        var attributedTitle = AttributedString(title)
        attributedTitle.font = Fonts.title2
        
        var config = UIButton.Configuration.plain()
        config.attributedTitle = attributedTitle
        
        configuration = config
    }
    
    private func updateAppearance() {
        backgroundColor = isEnabled ? Colors.primary : Colors.disabled
    }
}
