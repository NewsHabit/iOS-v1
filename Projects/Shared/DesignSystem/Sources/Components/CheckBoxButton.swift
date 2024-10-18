//
//  CheckBoxButton.swift
//  SharedDesignSystem
//
//  Created by 지연 on 10/19/24.
//

import UIKit

public final class CheckBoxButton: UIButton {
    private var config: UIButton.Configuration
    
    public override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    // MARK: - Init
    
    public init(title: String) {
        config = .plain()
        
        super.init(frame: .zero)
        
        setupButton(with: title)
        // Trait 변경 감지를 위한 등록
        registerForTraitChanges([UITraitUserInterfaceStyle.self]) { (self: Self, _) in
            self.updateAppearance()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupButton(with title: String) {
        contentHorizontalAlignment = .left
        layer.borderWidth = 1
        layer.masksToBounds = true
        
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 0)
        
        config.imagePlacement = .leading
        config.imagePadding = 14
        
        var attributedTitle = AttributedString(title)
        attributedTitle.font = Fonts.title3
    
        config.background.backgroundColor = .clear
        config.attributedTitle = attributedTitle
        
        updateAppearance()
    }
    
    private func updateAppearance() {
        layer.borderColor = (isSelected ? Colors.background : Colors.gray01).cgColor
        backgroundColor = isSelected ? Colors.secondary : Colors.background
        
        config.image = isSelected ? Images.checkActive : Images.checkInactive
        config.baseForegroundColor = isSelected ? Colors.primary : Colors.disabled
        
        configuration = config
    }
}
