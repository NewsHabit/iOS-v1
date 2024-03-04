//
//  WebViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/23/24.
//

import UIKit

class WebViewController: BaseViewController<WebView> {
    
    var urlString: String?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        guard let contentView = contentView as? WebView else { return }
        contentView.loadLink(urlString)
    }
    
    // MARK: - BaseViewControllerProtocol
    
    func setupNavigationBar() {
        setNavigationBarShareButtonAction(#selector(handleShareButtonTap))
    }
    
    // MARK: - objc Function
    
    @objc private func handleShareButtonTap() {
        guard let urlString = urlString else { return }
        let pasteboard = UIPasteboard.general
        pasteboard.string = urlString
        Toast.shared.makeToast("원본 링크를 복사했습니다")
    }
    
    func setShareButtonEnabled(_ isEnabled: Bool) {
        setNavigationBarShareButtonHidden(!isEnabled)
    }
    
}
