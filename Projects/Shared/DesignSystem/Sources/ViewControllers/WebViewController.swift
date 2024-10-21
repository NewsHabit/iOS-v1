//
//  WebViewController.swift
//  SharedDesignSystem
//
//  Created by 지연 on 10/19/24.
//

import UIKit
import WebKit

import SnapKit

open class WebViewController<View: WKWebView>: ViewController<View> {
    // MARK: - Components
    
    private lazy var toolBar = createStackView()
    public private(set) lazy var backwardButton = createButton(with: Images.chevronLeft)
    public private(set) lazy var forwardButton = createButton(with: Images.chevronRight)
    public private(set) lazy var exportButton = createButton(with: Images.export)
    public private(set) lazy var bookmarkButton = createButton(with: Images.bookmarkInactive)
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    // MARK: - Public Setup Methods
    
    public func setupToolBar(isBookmarkButtonHidden: Bool = false) {
        if isBookmarkButtonHidden {
            [backwardButton, forwardButton, UIView(), exportButton].forEach {
                toolBar.addArrangedSubview($0)
            }
        } else {
            [backwardButton, forwardButton, exportButton, bookmarkButton].forEach {
                toolBar.addArrangedSubview($0)
            }
        }
    }
    
    // MARK: - Private Setup Methods
    
    private func setupViewController() {
        setupNormalNavigationBar(rightIcon: Images.refresh)
        setBackgroundColor(Colors.gray01)
        
        view.addSubview(toolBar)
        toolBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(51)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        contentView.snp.remakeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(toolBar.snp.top)
        }
    }
    
    // MARK: - Helper Methods
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }
    
    private func createButton(with image: UIImage) -> UIButton {
        let button = UIButton()
        button.setImage(image, for: .normal)
        return button
    }
}
