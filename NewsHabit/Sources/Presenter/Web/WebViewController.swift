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
        if urlString == nil {
            urlString = "https://newshabit.org"
        }
        contentView.loadLink(urlString)
    }
    
    // MARK: - BaseViewControllerProtocol
    
    func setupNavigationBar() {
        setNavigationBarShareButtonAction(#selector(handleShareButtonTap))
    }
    
    // MARK: - objc Function
    
    @objc private func handleShareButtonTap() {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        self.present(activityViewController, animated: true)
    }
    
    func setShareButtonEnabled(_ isEnabled: Bool) {
        setNavigationBarShareButtonHidden(!isEnabled)
    }
    
}
